//
//  Settings.swift
//  KoviDorro
//
//  Created by Влад Мади on 21.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import Foundation
import RealmSwift

class SettingsPomodoro: Object {
    @objc dynamic var workTime: Int = 25
    @objc dynamic var longTime: Int = 20
    @objc dynamic var shortTime: Int = 5
}
