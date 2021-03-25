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
    var data = Persistence.shared.getItemsIcome().reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
        self.rxAndRealm()

    }
    
    private func rxAndRealm() {
        let realm = try! Realm()
        let income = realm.objects(Income.self)
        
        Observable.array(from: income).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            let sum: Float = realm.objects(Income.self).sum(ofProperty: "income")
            self.myMoney.text = "\(sum)"
            
        }).disposed(by: disposeBag)
    }
    
    private func configure() {
        addIncomeButton.layer.cornerRadius = 24
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addIncomeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddIncomeViewController") as! AddIncomeViewController
        vc.index = 0
        present(vc, animated: true, completion: nil)
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
