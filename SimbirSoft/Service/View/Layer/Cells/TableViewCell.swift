//
//  TableViewCell.swift
//  SimbirSoft
//
//  Created by Storm67 on 02/05/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

final class TableViewCell: UITableViewCell {
    
    var viewModel: TableViewTaskModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = "\(viewModel.hours):00 - \(viewModel.hours + 1):00"
            detailTextLabel?.text = viewModel.name
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
