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
    
    var myIncome: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
    }
    
    func configure() {
        addIncomeButton.layer.cornerRadius = 24
        myMoney.text = "\(myIncome.first ?? 0) руб"
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addIncomeAction(_ sender: Any) {
        let ac = UIAlertController(title: "Сумма", message: .none, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Сумма"
            textField.keyboardType = .numberPad
        }
        let alertAction = UIAlertAction(title: "Добавить доход", style: .cancel) { (alert) in
            guard let newItem = ac.textFields?.last?.text else { return }
            if newItem != "" {
                let item = Int(newItem)
                self.myIncome.append(item ?? 0)
                let summ = self.myIncome.reduce( 0, +)
                self.myMoney.text = "\(summ) руб"
                self.tableView.reloadData()
            }
        }
        
        ac.addAction(alertAction)
        present(ac, animated: true, completion: nil)
    }
    
}

extension IncomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myIncome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeCell", for: indexPath) as! IncomeCell
        cell.textLabel?.text = "\(myIncome[indexPath.row]) руб."
        
        return cell
    }
    
    
}
