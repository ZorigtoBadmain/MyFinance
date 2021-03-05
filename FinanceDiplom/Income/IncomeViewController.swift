//
//  IncomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit

class IncomeViewController: UIViewController {

    @IBOutlet weak var myMoney: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addIncomeButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var data = Persistence.shared.getItems() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
        
    }
    
    func configure() {
        addIncomeButton.layer.cornerRadius = 24
        
        myMoney.text = "\(Persistence.shared.summa())"
        print(Persistence.shared.summa())
   
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
//        cell.textLabel?.text = "\(myIncome[indexPath.row]) руб."
//        cell.textLabel?.text = "\(myInc[indexPath.row].income)"
        cell.configure(index: indexPath.row)
        
        
        return cell
    }
    
    
}
