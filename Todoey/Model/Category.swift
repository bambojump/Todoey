//
//  Category.swift
//  Todoey
//
//  Created by Youdo Leam on 25/7/18.
//  Copyright © 2018 Youdo Leam. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
