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

class PersistanseCredit {
    static let shared = PersistanseCredit()
    let realm = try! Realm()
    
    func save(item: Credit) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func getItemCredit() -> Results<Credit> {
        return realm.objects(Credit.self)
    }
}
