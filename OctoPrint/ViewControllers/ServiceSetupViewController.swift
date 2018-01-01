//
//  ServiceSetupViewController.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/17/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import UIKit

class ServiceSetupViewController: UIViewController {
    @IBOutlet weak var discoveryModal: DiscoveryModal!
    var service: NetService?
    private let viewModel = DiscoveryViewModel()
    private let formCellIdentifier = "formCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        discoveryModal.set(delegate: self, dataSource: self)
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
            return defaultFormCell(tableView, title: "Name", value: service?.name)
        case 1:
            return defaultFormCell(tableView, title: "Address",
                                   value: viewModel.format(hostName: service?.hostName))
        case 2:
            return apiKeyFormCell()
        default:
            return UITableViewCell()
        }

    }

    private func defaultFormCell(_ tableView: UITableView, title:String, value:String?) -> UITableViewCell {
        let dequedCell = tableView.dequeueReusableCell(
            withIdentifier: formCellIdentifier) as? DiscoveryModalTableViewCell
        let cell = dequedCell ?? ServiceSetupFormTableViewCell(title: title, value: value,
                                                               reuseIdentifier: formCellIdentifier)
        return cell
    }

    private func apiKeyFormCell() -> UITableViewCell {
        return UITableViewCell()
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
