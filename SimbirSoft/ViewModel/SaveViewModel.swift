//
//  SaveViewModel.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation

protocol AddTaskProtocol {
    func resolve()
    var realmService: RealmManager { get }
    func transformation(model: TaskModel)
    func delete()
}

final class AddTaskViewModel: AddTaskProtocol {
    
    internal let realmService: RealmManager
    
    init(realm: RealmManager) {
        self.realmService = realm
    }
    
    func transformation(model: TaskModel) {
        realmService.save(data: model)
    }
    
    func resolve() {
        realmService.read { (void) in
        }
    }
    
    func delete() {
        realmService.delete()
    }

    
}
