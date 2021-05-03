//
//  TaskListView.swift
//  SimbirSoft
//
//  Created by Storm67 on 02/05/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

protocol AddTask: class {
    func add()
}

final class TaskListView: UIView, UITextFieldDelegate {

    weak var addTask: AddTask?
    
    let textFieldName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Имя задачи", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let textFieldStart: UITextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Дата начала", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        return textField
    }()
    
    let textFieldTask: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Цель задачи", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let textFieldEnd: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Дата окончания", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.tag = 1
        textField.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        return textField
    }()
    
    let confirm: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Добавить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(confirm)
        addSubview(textFieldName)
        addSubview(textFieldStart)
        addSubview(textFieldTask)
        addSubview(textFieldEnd)
        NSLayoutConstraint.activate([
            textFieldName.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldTask.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldStart.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldEnd.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirm.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            textFieldTask.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            textFieldStart.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            textFieldEnd.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            confirm.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            textFieldName.heightAnchor.constraint(equalToConstant: 45),
            textFieldTask.heightAnchor.constraint(equalToConstant: 45),
            textFieldStart.heightAnchor.constraint(equalToConstant: 45),
            textFieldEnd.heightAnchor.constraint(equalToConstant: 45),
            confirm.heightAnchor.constraint(equalToConstant: 45),
            textFieldName.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            textFieldTask.topAnchor.constraint(equalTo: textFieldName.topAnchor, constant: 70),
            textFieldStart.topAnchor.constraint(equalTo: textFieldTask.topAnchor, constant: 70),
            textFieldEnd.topAnchor.constraint(equalTo: textFieldStart.topAnchor, constant: 70),
            confirm.topAnchor.constraint(equalTo: textFieldEnd.topAnchor, constant: 70)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        addGestureRecognizer(tap)
        showDatePicker()
    }
    
    @objc fileprivate func showDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        textFieldStart.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        textFieldEnd.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0)))
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        textFieldStart.inputAccessoryView = toolbar
        textFieldStart.inputView = datePicker
        textFieldEnd.inputAccessoryView = toolbar
        textFieldEnd.inputView = datePicker
    }
    
    @objc fileprivate func donedatePicker(sender: UITextField) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)
        let text = formatter.string(from: datePicker.date)
        if textFieldStart.isFirstResponder {
            textFieldStart.text = text
        }
        if textFieldEnd.isFirstResponder {
            textFieldEnd.text = text
        }
    }
    
    @objc fileprivate func cancelDatePicker() {
        self.endEditing(true)
    }
    
    @objc fileprivate func add() {
        addTask?.add()
    }
    
}
