//
//  Category.swift
//  TaskTastic
//
//  Created by Rohin Madhavan on 06/05/2024.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
