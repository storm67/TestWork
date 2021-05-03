//
//  CollectionViewCell.swift
//  SimbirSoft
//
//  Created by Storm67 on 30/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
     
    lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()
    
    func layout() {
    addSubview(label)
    NSLayoutConstraint.activate([
    label.centerXAnchor.constraint(equalTo: centerXAnchor),
    label.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
    
    var days: Int? {
        didSet {
            guard let days = days else { return }
            label.text = "\(days)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = .black
    }
    
}
