//
//  TaskListCoordinator.swift
//  SimbirSoft
//
//  Created by Storm67 on 02/05/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

class TaskListCoordinator {
    
    fileprivate let factory: TaskListFactoryResolver
    
    init(factory: TaskListFactoryResolver) {
        self.factory = factory
    }
    
    func start(_ previous: UIViewController, _ navigationController: UINavigationController) {
        let taskListViewController = factory.resolveTaskListViewController()
        navigationController.present(taskListViewController, animated: true, completion: nil)
    }
}
