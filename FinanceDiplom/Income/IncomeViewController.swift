//
//  IncomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class IncomeViewController: UIViewController {

    @IBOutlet weak var myMoney: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addIncomeButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    
    var data = Persistence.shared.getItemsIcome()
    var summa = Persistence.shared.summa()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
        self.rxAndRealm()
        
    }
    
    func rxAndRealm() {
        let realm = try! Realm()
        let income = realm.objects(IncomeData.self)
        Observable.array(from: income).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            let sum: Float = realm.objects(IncomeData.self).sum(ofProperty: "income")
            self.myMoney.text = "\(sum)"
            
        }).disposed(by: disposeBag)
    }
    
    func configure() {
        addIncomeButton.layer.cornerRadius = 24
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension IncomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeCell", for: indexPath) as! IncomeCell
        cell.configure(index: indexPath.row)
        
        
        return cell
    }
    
}
