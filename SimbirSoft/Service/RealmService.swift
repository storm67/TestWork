//
//  RealmService.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmManager {
    func save(data: TaskModel)
    func read(completion: @escaping (Any) -> Void)
    func delete()
}

final class RealmService: RealmManager {
    
     var realm: Realm {
           get {
               do { return try Realm(configuration: config) }
               catch { print(error) }
               return self.realm
           }
       }
    var config = Realm.Configuration(
        schemaVersion: 3,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {

            }
    })
    
           
    
    func save(data: TaskModel) {
        try! realm.write({
            realm.add(data)
        })
    }
    
    func read(completion: @escaping (Any) -> Void) {
        let data = realm.objects(TaskModel.self)
        do {
            //print(data.count)
            for i in 0..<data.count {
            let collector = data[i].data
            let decoder = try JSONSerialization.jsonObject(with: collector, options: [])
            completion(decoder)
            print(decoder)
                
            }
        }  catch { print(error)}
    }
    
    func delete() {
        try! realm.write { realm.deleteAll() }
    }
}


