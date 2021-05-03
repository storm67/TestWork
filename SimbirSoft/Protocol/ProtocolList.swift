//
//  Factory.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation

protocol MainFactoryResolver {
    func resolveMainCoordinator() -> Coordinator
    func resolveMainView() -> MainView
    func resolveMainViewController(coordinator: CoordinatorCommands) -> ViewController
}

@objc protocol CoordinatorCommands {
    func nextViewController()
}

protocol TaskCreaterFactoryResolver {
    func resolveTaskCreaterController() -> TaskCreaterController
    func resolveTaskCreaterView() -> TaskListView
}

protocol TaskListFactoryResolver {
    func resolveCoordinator() -> TaskListCoordinator
    func resolveTaskListViewController() -> TaskCreaterController
}
