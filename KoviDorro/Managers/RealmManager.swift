//
//  RealmManager.swift
//  KoviDorro
//
//  Created by Влад Мади on 21.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class RealmManager {
    
    func addToDB(object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }

    func removeFromDB(object: Object)  {
        try! realm.write {
            realm.delete(object)
        }
    }
    
}
