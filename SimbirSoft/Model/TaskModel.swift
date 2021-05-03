//
//  TaskModel.swift
//  SimbirSoft
//
//  Created by Storm67 on 03/05/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class TaskModel: Object {
    @objc dynamic var data: Data = Data()
    //@objc dynamic var str: String = ""
}
