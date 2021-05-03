//
//  DependencyContainer.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import RealmSwift

class DependencyContainer {
    lazy var dateManager = DateManager()
    lazy var realmService = RealmService()
    lazy var viewModel = CalendarViewModel(dateManager: dateManager, realmManager: realmService)
    lazy var addTaskViewModel = AddTaskViewModel(realm: realmService)
}
extension DependencyContainer: MainFactoryResolver {
    
    func resolveMainView() -> MainView {
        MainView()
    }
    
    func resolveMainViewController(coordinator: CoordinatorCommands) -> ViewController {
        ViewController(factory: self, coordinator: coordinator, viewModel: viewModel)
    }
    
    func resolveMainCoordinator() -> Coordinator {
        Coordinator(factory: self)
    }
    
}

extension DependencyContainer: TaskCreaterFactoryResolver {
    
    func resolveTaskCreaterView() -> TaskListView {
        TaskListView()
    }
    
    func resolveTaskCreaterController() -> TaskCreaterController {
        TaskCreaterController(factory: self, viewModel: addTaskViewModel)
    }
    
}

extension DependencyContainer: TaskListFactoryResolver {
    
    func resolveViewModel() -> AddTaskViewModel {
        AddTaskViewModel(realm: realmService)
    }
    
    func resolveTaskListViewController() -> TaskCreaterController {
        TaskCreaterController(factory: self, viewModel: resolveViewModel())
    }
    
    func resolveCoordinator() -> TaskListCoordinator {
        TaskListCoordinator(factory: self)
    }
    
}
