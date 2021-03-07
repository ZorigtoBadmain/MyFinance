//
//  PersistenceRealm.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 05.03.2021.
//

import Foundation
import RealmSwift

class IncomeData: Object {
    @objc dynamic var income: Float = 0
   
    func getIncome(income: Float) {
        try? Persistence.shared.realm.write {
            self.income = income
        }
    }
    
}

class ExpanceData: Object {
    @objc dynamic var expance: String = ""
    @objc dynamic var credit: Credit?
    
    func getExpance(expance: String) {
        try? Persistence.shared.realm.write {
            self.expance = expance
        }
    }
}

class Persistence {
    static let shared = Persistence()
    let realm = try! Realm()
    
    
    func saveIncome(item: IncomeData) {
        try! realm.write {
            
            realm.add(item)
            
        }
    }
    
    func saveExpance(item: ExpanceData) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func summa() -> Float {
        
        let allTime: Float = realm.objects(IncomeData.self).sum(ofProperty: "income")
        return allTime
    }
    
    func getItemsIcome() -> Results<IncomeData> {
        
        return realm.objects(IncomeData.self)
    }
    
    func getItemsExpance() -> Results<ExpanceData> {
        return realm.objects(ExpanceData.self)
    }

}
