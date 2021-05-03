//
//  Coordinator.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    fileprivate let factory: MainFactoryResolver & TaskListFactoryResolver
    fileprivate weak var loaded: UIViewController?
    
    init(factory: MainFactoryResolver & TaskListFactoryResolver) {
        self.factory = factory
    }
    
    func start(_ navigationController: UINavigationController) {
        let mainViewController = factory.resolveMainViewController(coordinator: self)
        loaded = mainViewController
        navigationController.viewControllers = [mainViewController]
    }
    
}

extension Coordinator: CoordinatorCommands {
    
    @objc func nextViewController() {
        guard let navigator = loaded?.navigationController, let visible = navigator.visibleViewController else { return }
        let taskViewController = factory.resolveCoordinator()
        taskViewController.start(visible, navigator)
    }
    
    
}
