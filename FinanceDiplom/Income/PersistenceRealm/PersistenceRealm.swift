//
//  PersistenceRealm.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 05.03.2021.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

class ItemList: Object {
   let items = List<Income>()
}

class Income: Object {
    @objc dynamic var income: Float = 0
   
    func getIncome(income: Float) {
        try? Persistence.shared.realm.write {
            self.income = income
        }
    }
    
}

class ExpanceData: Object {
    
    @objc dynamic var expance: String = ""
    let creditBuy = List<Credit>()
    
    convenience  init(expance: String) {
        self.init()
        
        self.expance = expance
        
    }
    
    func getExpance(expance: String) {
        try? Persistence.shared.realm.write {
            self.expance = expance
        }
    }
}

class Persistence {
    static let shared = Persistence()
    let realm = try! Realm()
    
    
    func addCredit(credit: Credit) {
        try! realm.write {
            let expance = ExpanceData()
            expance.creditBuy.append(credit)
            realm.add(expance)
        }
    }
    
    func saveIncome(item: Income) {
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
        
        let allTime: Float = realm.objects(Income.self).sum(ofProperty: "income")
        
        return allTime
    }
    
    func getItemsIcome() -> Results<Income> {
        
        return realm.objects(Income.self)
    }
    
    func getItemsExpance() -> Results<ExpanceData> {
        return realm.objects(ExpanceData.self)
    }

}
