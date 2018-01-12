//
//  ItemPicker.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/12/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit

class ItemPicker: NSObject {
    private var cancelAction: (() -> Void)?
    private var doneAction: ((String) -> Void)?
    private var items = [String]()
    private var containerView: UIView?
    private var selectedItem = ""
    let itemPickerView: ItemPickerView = {
        let view = ItemPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var pickerViewExpandedConstraint: [NSLayoutConstraint] =
        [NSLayoutConstraint(item: self.itemPickerView, attribute: .bottom, relatedBy: .equal,
                            toItem: self.containerView, attribute: .bottom, multiplier: 1, constant: 0)]

    private lazy var pickerViewCollapsedConstraint: [NSLayoutConstraint] =
        [NSLayoutConstraint(item: self.itemPickerView, attribute: .top, relatedBy: .equal,
                            toItem: self.containerView, attribute: .bottom, multiplier: 1, constant: 0)]

    init(containerView: UIView?) {
        self.containerView = containerView
        super.init()
        setupPicker()
        setupConstraints()
    }

    func showPicker(for items:[String], done: ((String) -> Void)?, cancel: (() -> Void)?) {
        self.items = items
        doneAction = done
        cancelAction = cancel
        selectedItem = items[0]

        itemPickerView.pickerView.reloadAllComponents()
        itemPickerView.pickerView.selectRow(0, inComponent: 0, animated: false)

        NSLayoutConstraint.deactivate(pickerViewCollapsedConstraint)
        NSLayoutConstraint.activate(pickerViewExpandedConstraint)

        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.containerView?.layoutIfNeeded()
        }
    }

    func hidePicker() {
        NSLayoutConstraint.activate(pickerViewCollapsedConstraint)
        NSLayoutConstraint.deactivate(pickerViewExpandedConstraint)

        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.containerView?.layoutIfNeeded()
        }
    }

    private func setupPicker() {
        itemPickerView.pickerView.delegate = self
        itemPickerView.pickerView.dataSource = self
        containerView?.addSubview(itemPickerView)

        itemPickerView.cancelAction = { [unowned self] in
            self.hidePicker()

            if let cancel = self.cancelAction {
                cancel()
            }
        }

        itemPickerView.doneAction = { [unowned self] in
            self.hidePicker()

            if let done = self.doneAction {
                done(self.selectedItem)
            }
        }
    }

    private func setupConstraints() {
        let views = [
            "itemPickerView": itemPickerView
        ]

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[itemPickerView]|",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:[itemPickerView]",
                                           options: [], metrics: nil, views: views))

        NSLayoutConstraint.activate(pickerViewCollapsedConstraint)
    }
}

extension ItemPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[row]
    }
}
