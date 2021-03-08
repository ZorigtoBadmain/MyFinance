//
//  CostCategoryViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class CostCategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCostButton: UIButton!
    @IBOutlet weak var paymentSchaduleButton: UIButton!
    
    let credit = PersistanseCredit.shared.getItemCredit()
    var index = 0
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
        getReload()
        
    }
    
    func configure() {
        paymentSchaduleButton.layer.cornerRadius = 24
        addCostButton.layer.cornerRadius = 26
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getReload() {
        let realm = try! Realm()
        let income = realm.objects(Credit.self)
        Observable.array(from: income).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }
    
    @IBAction func paymentAction(_ sender: Any) {
    }
    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddCreditController") as! AddCreditController
        vc.index = index
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CostCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostCell", for: indexPath) as! CostCell
        let cred = credit[indexPath.row]
        cell.money.text = "\(cred.number)"
        cell.nameCategory.text = cred.name
        cell.date.text = cred.date
        
        return cell
    }
    
}
