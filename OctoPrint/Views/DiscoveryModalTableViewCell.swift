//
//  DiscoveryModalTableViewCell.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/1/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit
import CommonCodePhone

class DiscoveryModalTableViewCell: UITableViewCell {
    let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.named(Constants.Colors.harvestGold)
        return view
    }()

    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textColor = UIColor.darkGray
        return view
    }()

    let detailLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.lightGray
        return view
    }()

    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = circleView.backgroundColor
        super.setSelected(selected, animated: animated)
        circleView.backgroundColor = color
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = circleView.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        circleView.backgroundColor = color
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(circleView)
    }

    private func setupConstraints() {
        let views = [
            "circleView":circleView,
            "titleLabel":titleLabel,
            "detailLabel":detailLabel
        ]

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[circleView(8)]-10-[titleLabel]-|",
                                           options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[circleView(8)]-10-[detailLabel]-|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[circleView(8)]",
                                       options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[titleLabel][detailLabel]-12-|",
                                       options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            [NSLayoutConstraint(item: circleView, attribute: .centerY, relatedBy: .equal,
                                toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)])

    }
}
