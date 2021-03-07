//
//  IncomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

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
        
    }
    
    func configure() {
        
        addIncomeButton.layer.cornerRadius = 24
        addIncomeButton.rx.tap.subscribe(onNext: {
            self.tableView.reloadData()
        })
        
        myMoney.text = "\(summa) руб."

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
