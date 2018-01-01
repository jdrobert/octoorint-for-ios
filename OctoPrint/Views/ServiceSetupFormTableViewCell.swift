//
//  ServiceSetupFormTableViewCell.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/1/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit

class ServiceSetupFormTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textColor = UIColor.darkGray
        return view
    }()

    let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textColor = UIColor.darkGray
        return view
    }()

    init(title:String, value:String?, reuseIdentifier:String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        titleLabel.text = title
        textField.text = value
        textField.placeholder = title

        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }

    private func setupConstraints() {
        let views = [
            "titleLabel":titleLabel,
            "textField":textField
        ]

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-[textField]-|",
                                           options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[titleLabel]-11-|",
                                           options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[textField]-11-|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            [NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem:titleLabel ,
                                attribute: .width, multiplier: 1.75, constant: 0)])
    }
}
