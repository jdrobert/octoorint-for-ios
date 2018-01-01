//
//  DiscoveryModal.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/11/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import UIKit

class DiscoveryModal: UIView {

    private let tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 53
        return tableView
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(tableView)
        clipsToBounds = true
        setupConstraints()
    }

    func set(delegate:UITableViewDelegate, dataSource:UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    func reloadData() {
        tableView.reloadData()
    }

    private func setupConstraints() {
        let views = ["tableView": tableView]

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views))
    }
}
