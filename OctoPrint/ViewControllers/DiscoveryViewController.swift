//
//  DiscoveryViewController.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/11/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import UIKit
import CommonCodePhone

class DiscoveryViewController: UIViewController {
    @IBOutlet weak var discoveryModal: DiscoveryModal!

    private let client = DiscoveryClient()
    private let octoPrintType = "_octoprint._tcp"
    private let octoPrintCellIdentifier = "octoPrintCell"
    private let discoveryDuration: TimeInterval = 3
    private let viewModel = DiscoveryViewModel()

    private var discoveredServices = [NetService]()

    override func viewDidLoad() {
        discoveryModal.set(delegate: self, dataSource: self)
        title = NSLocalizedString(Constants.Localization.discoveryVCTitle, comment: "")
        navigationController?.navigationBar.tintColor = UIColor.white
        startDiscovery()
    }

    private func setupNavbarSpinner() {
        let activitySpinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activitySpinner.startAnimating()

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activitySpinner)
    }

    private func setupNavbarRefreshButton() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                            target: self, action: #selector(startDiscovery))
        barButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func startDiscovery() {
        discoveredServices.removeAll()
        discoveryModal.reloadData()

        setupNavbarSpinner()
        client.startDiscovery(with: octoPrintType) { [weak self] services in
            self?.discoveredServices = services
            self?.discoveryModal.reloadData()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + discoveryDuration) { [weak self] in
            self?.stopDiscovery()
            self?.setupNavbarRefreshButton()
        }
    }

    private func stopDiscovery() {
        client.stopDiscovery()
    }
}

extension DiscoveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredServices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = discoveredServices[indexPath.row]

        let dequedCell = tableView.dequeueReusableCell(
            withIdentifier: octoPrintCellIdentifier) as? DiscoveryModalTableViewCell
        let cell = dequedCell ?? DiscoveryModalTableViewCell(reuseIdentifier: octoPrintCellIdentifier)

        cell.titleLabel.text = service.name
        cell.detailLabel.text = viewModel.format(hostName: service.hostName)
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let service = discoveredServices[indexPath.row]
        if let serviceSetupVC = storyboard?.instantiateViewController(
            withIdentifier: "sb_service_setup") as? ServiceSetupViewController {
            serviceSetupVC.service = service
            navigationController?.pushViewController(serviceSetupVC, animated: true)
        }
    }
}
