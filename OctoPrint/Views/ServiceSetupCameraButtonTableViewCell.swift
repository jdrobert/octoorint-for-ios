//
//  ServiceSetupCameraButtonTableViewCell.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/5/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit

class ServiceSetupCameraButtonTableViewCell: UITableViewCell {

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
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.darkGray
        view.textAlignment = .right
        return view
    }()

    let textFieldButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"qr_scan"), for: .normal)
        button.clipsToBounds = true
        return button
    }()

    init(title:String, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        titleLabel.text = title
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(textFieldButton)
    }

    private func setupConstraints() {
        let views = [
            "titleLabel":titleLabel,
            "textField":textField,
            "textFieldButton":textFieldButton
        ]

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|-[titleLabel]-[textField]-[textFieldButton(50)]-|",
                                           options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-19-[textField]-19-|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-19-[titleLabel]-19-|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[textFieldButton]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            [NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem:titleLabel ,
                                attribute: .width, multiplier: 1.75, constant: 0)])
    }
}
