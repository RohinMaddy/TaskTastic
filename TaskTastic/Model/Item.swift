//
//  Item.swift
//  TaskTastic
//
//  Created by Rohin Madhavan on 06/05/2024.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
