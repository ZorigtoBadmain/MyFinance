//
//  Credit.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 07.03.2021.
//

import Foundation
import RealmSwift

class Credit: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var number: Float = 0
    
    convenience init(name: String, date: String, number: Float) {
        self.init()
        self.name = name
        self.date = date
        self.number = number
    }
}
