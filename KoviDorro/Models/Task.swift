//
//  Task.swift
//  KoviDorro
//
//  Created by Влад Мади on 21.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var descript: String = ""
    @objc dynamic var isEnjoy: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
