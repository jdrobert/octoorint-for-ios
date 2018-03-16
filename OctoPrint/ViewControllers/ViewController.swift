//
//  ViewController.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import UIKit
import CommonCodePhone

class ViewController: UIViewController {

    @IBOutlet weak private var connectionInfoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var connectionInfoTitleIndicator: UIView!
    @IBOutlet weak private var connectionInfoTitleLabel: UILabel!
    @IBOutlet weak private var connectionInfoPortView: ConnectionInfoView!
    @IBOutlet weak private var connectionInfoBaudrateView: ConnectionInfoView!
    @IBOutlet weak private var connectionInfoProfileView: ConnectionInfoView!
    @IBOutlet weak private var scrollView: UIScrollView!

    private let connectionInfoExpandedHeight: CGFloat = 182.0
    private let connectionInfoCollapsedHeight: CGFloat = 0.0
    private let connectionInfo = PrinterConnectionInfoStore()
    private let dashboardViewModel = DashboardViewModel()
    private var currentConnectionInfo: OPConnectionInformation?
    private var itemPicker: ItemPicker?
    private var selectedPort = ""
    private var selectedBaudrate = ""
    private var selectedProfile = ""
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = connectionInfo.name
        connectionInfoHeightConstraint.constant = connectionInfoCollapsedHeight
        //NotificationCenter.default.addObserver(self, selector: #selector(syncWithWatch),
            //name: NSNotification.Name(rawValue: Constants.Notifications.watchSessionReady), object: nil)

        //WatchSessionManager.shared.setupManager()

        scrollView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadConnection), for: .valueChanged)
        itemPicker = ItemPicker(containerView: UIApplication.shared.keyWindow?.rootViewController?.view)

        loadConnection()
    }

    @objc private func loadConnection() {
        connectionInfoTitleIndicator.backgroundColor = UIColor.named(Constants.Colors.harvestGold)
        connectionInfoTitleLabel.text = "Checking connection"

        NetworkHelper.shared.getConnectionInformation(success: { [weak self] connection in
            self?.currentConnectionInfo = connection
            self?.connectionInfoTitleLabel.text = connection.current.state
            self?.refreshControl.endRefreshing()
            self?.toggleEditIconsIfNeeded()

            if PrinterStateHelper.isDisconnected(connection.current.state) {
                self?.connectionInfoTitleIndicator.backgroundColor = UIColor.named(Constants.Colors.burgundy)
                self?.setupDisconnectedLabels(connection)
                self?.openConnectionInfo()
            } else {
                self?.connectionInfoTitleIndicator.backgroundColor = UIColor.named(Constants.Colors.darkGreen)
                self?.setupConnectedLabels(connection)
            }
            }, failure: { [weak self] in
                self?.refreshControl.endRefreshing()
        })
    }

    private func toggleEditIconsIfNeeded() {
        if let connection = currentConnectionInfo {
            connectionInfoPortView.editIcon.isHidden = connection.options.ports.isEmpty
            connectionInfoBaudrateView.editIcon.isHidden = connection.options.baudrates.isEmpty
            connectionInfoProfileView.editIcon.isHidden = connection.options.printerProfiles.isEmpty
        }
    }

    private func setupConnectedLabels(_ connection: OPConnectionInformation) {

    }

    private func setupDisconnectedLabels(_ connection: OPConnectionInformation) {
        selectedPort = dashboardViewModel.getPortName(connection)
        connectionInfoPortView.detailLabel.text = selectedPort

        selectedBaudrate = String(connection.options.baudratePreference)
        connectionInfoBaudrateView.detailLabel.text = selectedBaudrate

        selectedProfile = dashboardViewModel.getProfileName(
            for: connection.options.printerProfilePreference, profiles: connection.options.printerProfiles)
        connectionInfoProfileView.detailLabel.text = selectedProfile
    }

    private func showPicker(for items:[String], selected: String, done: @escaping (String) -> Void) {
        itemPicker?.showPicker(for: items, selected: selected,  done: { selectedItem in
            done(selectedItem)
        }, cancel: nil)
    }

    @IBAction private func showPortPicker() {
        if let connection = currentConnectionInfo, !connection.options.ports.isEmpty {
            highlight(row: connectionInfoPortView)
            showPicker(for: connection.options.ports, selected: selectedPort,
                       done: { [weak self] selectedItem in
                self?.selectedPort = selectedItem
                self?.connectionInfoPortView.detailLabel.text = selectedItem
            })
        }
    }

    @IBAction private func showBaudratePicker() {
        if let connection = currentConnectionInfo, !connection.options.baudrates.isEmpty {
            highlight(row: connectionInfoBaudrateView)
            showPicker(for: dashboardViewModel.getBaudratesArray(connection.options.baudrates),
                       selected: selectedBaudrate ,done: { [weak self] selectedItem in
                self?.selectedBaudrate = selectedItem
                self?.connectionInfoBaudrateView.detailLabel.text = selectedItem
            })
        }
    }

    @IBAction private func showProfilePicker() {
        if let connection = currentConnectionInfo, !connection.options.printerProfiles.isEmpty {
            highlight(row: connectionInfoProfileView)
            showPicker(for: dashboardViewModel.getProfileNames(connection.options.printerProfiles),
                       selected: selectedProfile, done: { [weak self] selectedItem in
                self?.selectedProfile = selectedItem
                self?.connectionInfoProfileView.detailLabel.text = selectedItem
            })
        }
    }

    private func highlight(row: UIView) {
        UIView.animate(withDuration: 0.125, animations: {
            row.backgroundColor = UIColor.named(Constants.Colors.cellHighlightGray)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.125, animations: {
                row.backgroundColor = UIColor.white
            })
        })
    }

    private func openConnectionInfo() {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.connectionInfoHeightConstraint.constant = self.connectionInfoExpandedHeight
            self.view.layoutIfNeeded()
        }
    }
    private func toggleConnectionInfo() {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            if self.connectionInfoHeightConstraint.constant == 0 {
                self.connectionInfoHeightConstraint.constant = self.connectionInfoExpandedHeight
            } else {
                self.connectionInfoHeightConstraint.constant = self.connectionInfoCollapsedHeight
            }

            self.view.layoutIfNeeded()
        }
    }
    @IBAction private func connectionInfoHeaderTapAction(tapGesture: UITapGestureRecognizer) {
        toggleConnectionInfo()
    }

    @objc private func syncWithWatch() {
        if let cachedValues = connectionInfo.getCachedValues() {
            try? WatchSessionManager.shared.updateApplicationContext(
                applicationContext: ["connectionInfo":cachedValues])
        }

    }
}
