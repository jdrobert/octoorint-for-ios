//
//  ServiceSetupViewController.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/17/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import UIKit
import AVFoundation

class ServiceSetupViewController: UIViewController {
    @IBOutlet weak var discoveryModal: DiscoveryModal!
    var service: NetService?
    private let viewModel = DiscoveryViewModel()
    private let formCellIdentifier = "formCell"
    private let apiKeyCellIdentifier = "apiKeyCell"
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private lazy var captureSession: AVCaptureSession = {
        return AVCaptureSession()
    }()

    private var nameTextField: UITextField?
    private var hostNameTextField: UITextField?
    private var apiKeyTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        discoveryModal.set(delegate: self, dataSource: self)
    }

    @objc private func launchCameraAction() {
        if hasCameraPermission() {
            launchCamera()
        } else {
            requestCameraPermission(with: { [weak self] success in
                if success {
                    self?.launchCamera()
                }
            })
        }
    }

    private func launchCamera() {
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                if captureSession.inputs.isEmpty {
                    let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
                    captureSession.addInput(deviceInput)

                    let captureMetadataOutput = AVCaptureMetadataOutput()
                    captureSession.addOutput(captureMetadataOutput)

                    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    if captureMetadataOutput.availableMetadataObjectTypes.contains(.qr) {
                        captureMetadataOutput.metadataObjectTypes = [.qr]
                    }
                }

                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = navigationController?.view.bounds ?? .zero

                if let previewLayer = videoPreviewLayer {
                    navigationController?.view.layer.addSublayer(previewLayer)
                }

                captureSession.startRunning()

            } catch {}
        }
    }

    private func hasCameraPermission() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        let cameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)

        return cameraAvailable && (status == .authorized)
    }

    private func requestCameraPermission(with completion:@escaping ((Bool) -> Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: completion)
        }
    }

}

extension ServiceSetupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1 {
            return setupSubmitSection()
        } else {
            return setupFormSection(tableView, indexPath:indexPath)
        }
    }

    private func setupFormSection(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = defaultFormCell(tableView, title: "Name", value: service?.name)
            nameTextField = cell.textField
            return cell
        case 1:
            let cell = defaultFormCell(tableView, title: "Address",
                                   value: viewModel.format(hostName: service?.hostName))
            hostNameTextField = cell.textField
            return cell
        case 2:
            let cell = apiKeyFormCell(tableView)
            apiKeyTextField = cell.textField
            return cell
        default:
            return UITableViewCell()
        }

    }

    private func defaultFormCell(_ tableView: UITableView,
                                 title:String, value:String?) -> ServiceSetupFormTableViewCell {
        let dequedCell = tableView.dequeueReusableCell(
            withIdentifier: formCellIdentifier) as? ServiceSetupFormTableViewCell
        let cell = dequedCell ?? ServiceSetupFormTableViewCell(title: title, value: value,
                                                               reuseIdentifier: formCellIdentifier)
        return cell
    }

    private func apiKeyFormCell(_ tableView: UITableView) -> ServiceSetupCameraButtonTableViewCell {
        let dequedCell = tableView.dequeueReusableCell(
            withIdentifier: formCellIdentifier) as? ServiceSetupCameraButtonTableViewCell
        let cell = dequedCell ?? ServiceSetupCameraButtonTableViewCell(title:"API Key",
                                                                       reuseIdentifier: apiKeyCellIdentifier)
        cell.textFieldButton.addTarget(self, action: #selector(launchCameraAction), for: .touchUpInside)
        return cell
    }

    private func setupSubmitSection() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = "Save"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

extension ServiceSetupViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        if
            !metadataObjects.isEmpty,
            let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject,
            metadataObject.type == .qr {
            apiKeyTextField?.text = metadataObject.stringValue
            captureSession.stopRunning()
            videoPreviewLayer?.removeFromSuperlayer()
        }
    }
}
