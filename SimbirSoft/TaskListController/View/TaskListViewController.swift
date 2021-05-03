//
//  TaskListViewController.swift
//  SimbirSoft
//
//  Created by Storm67 on 02/05/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import UIKit

final class TaskCreaterController: UIViewController, AddTask {

    var factory: TaskCreaterFactoryResolver
    var viewModel: AddTaskViewModel
    
    init(factory: TaskCreaterFactoryResolver, viewModel: AddTaskViewModel) {
        self.factory = factory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view().addTask = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func view() -> TaskListView {
       return view as! TaskListView
    }
    
    override func loadView() {
        view = factory.resolveTaskCreaterView()
    }
    
    func add() {
        //viewModel.delete()
        let taskModel = TaskModel()
        let name = view().textFieldName.text
        let description = view().textFieldTask.text
        guard let start = view().textFieldStart.text,
        let end = view().textFieldEnd.text else { return }
        print(String(start.currentTimeInMiliseconds()),String(end.currentTimeInMiliseconds()))
        var collection = [String:String]()
        collection["name"] = name
        collection["description"] = description
        collection["start"] = String(start.currentTimeInMiliseconds())
        collection["end"] = String(end.currentTimeInMiliseconds())
        let data = encoder(collection: collection)
        taskModel.data = data
        viewModel.transformation(model: taskModel)
        print(viewModel.resolve())
    }
    
    func encoder(collection: [String:String]) -> Data {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(collection)
        } catch { print(error) }
        return Data()
    }

}

