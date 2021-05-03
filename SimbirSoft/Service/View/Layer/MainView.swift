//
//  MainView.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

final class MainView: UIView {
    
    weak var delegate: Switcher?
    lazy var array = [UILabel]()

    let month: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 45, height: 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    let year: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
        
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 29.5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let leftButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "lessthan")?.withRenderingMode(.alwaysTemplate)
        image?.withTintColor(.black)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(switcher), for: .touchUpInside)
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        let image = UIImage(systemName: "greaterthan")?.withRenderingMode(.alwaysTemplate)
        image?.withTintColor(.black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(switcher), for: .touchUpInside)
        return button
    }()
    
    let addTask: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        image?.withTintColor(.black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(switcher), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(addTask)
        addSubview(year)
        addSubview(rightButton)
        addSubview(leftButton)
        addSubview(month)
        addSubview(collectionView)
        addSubview(stackView)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            year.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            year.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            leftButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -250),
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 150),
            rightButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -150),
            rightButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 250),
            month.centerXAnchor.constraint(equalTo: centerXAnchor),
            month.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 170),
            collectionView.heightAnchor.constraint(equalToConstant: 340),
            collectionView.widthAnchor.constraint(equalToConstant: 345),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 530),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.widthAnchor.constraint(equalToConstant: 345),
        ])
        backgroundColor = .white
        createLabels()
    }
    
    func update(year: Int, month: String) {
        self.year.text = "\(year)"
        self.month.text = month
    }
    
    func updateMonth(month: String) {
        self.month.text = month
    }
    
    func updateYear(year: Int) {
        self.year.text = "\(year)"
    }
    
    @objc func switcher(sender: UIButton) {
        delegate?.switchNext(sender: sender)
    }
    
    func createLabels() {
           let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
           for (key) in 0..<days.count {
               let label = UILabel()
               label.text = days[key]
               array.append(label)
               stackView.addArrangedSubview(array[key])
           }
       }
    
}

protocol Switcher: class {
    func switchNext(sender: UIButton)
}
