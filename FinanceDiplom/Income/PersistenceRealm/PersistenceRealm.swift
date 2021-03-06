//
//  PersistenceRealm.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 05.03.2021.
//

import Foundation
import RealmSwift

class IncomeData: Object {
    @objc dynamic var income: Double = 0
    
    func getIncome(income: Double) {
        self.income = income
    }
}

class Persistence {
    static let shared = Persistence()
    let realm = try! Realm()
    
    
    func save(item: IncomeData) {
        try! realm.write {
            
            realm.add(item)
        }
    }
    
    func summa() -> Double {
        let allTime: Double = realm.objects(IncomeData.self).sum(ofProperty: "income")
        return allTime
    }
    
    func getItems() -> Results<IncomeData> {
        return realm.objects(IncomeData.self)
    }
    
//    func remove() {
//        
//    }
}
