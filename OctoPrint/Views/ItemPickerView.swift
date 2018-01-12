//
//  ItemPickerView.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/12/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit

class ItemPickerView: UIView {
    var cancelAction: (() -> Void)?
    var doneAction: (() -> Void)?

    let pickerView: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let pickerContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let buttonContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var cancelButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Cancel", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return view
    }()

    private lazy var doneButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Done", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        return view
    }()

    private var selectedItem = ""

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        addSubview(pickerContainer)
        pickerContainer.addSubview(pickerView)
        pickerContainer.addSubview(buttonContainer)
        buttonContainer.addSubview(cancelButton)
        buttonContainer.addSubview(doneButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func cancelButtonAction() {
        if let cancel = cancelAction {
            cancel()
        }
    }

    @objc private func doneButtonAction() {
        if let done = doneAction {
            done()
        }
    }

    private func setupConstraints() {
        let views: [String:UIView] = [
            "pickerContainer":pickerContainer,
            "pickerView": pickerView,
            "buttonContainer": buttonContainer,
            "cancelButton": cancelButton,
            "doneButton":doneButton
        ]

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[pickerContainer]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[pickerContainer]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cancelButton]",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:[doneButton]-|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[pickerView]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[buttonContainer]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[buttonContainer(35@750)][pickerView]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[cancelButton]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[doneButton]|",
                                           options: [], metrics: nil, views: views))
    }
}
