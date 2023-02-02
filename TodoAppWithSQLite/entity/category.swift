//
//  category.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 2.02.2023.
//

import Foundation

class Category {
    var category_id:Int?
    var category_name:String?
    
    init(category_id: Int, category_name: String) {
        self.category_id = category_id
        self.category_name = category_name
    }
}
