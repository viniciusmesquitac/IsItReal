//
//  Repository.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Object
    func getAll() -> [Object]
    func get(id: Int) -> Object?
    func add(object: Object) -> Bool
    func update(object: Object) -> Bool
    func delete(object: Object) -> Bool
}
