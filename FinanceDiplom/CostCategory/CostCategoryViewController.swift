//
//  CostCategoryViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit

class CostCategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCostButton: UIButton!
    @IBOutlet weak var paymentSchaduleButton: UIButton!
    
    let credit = PersistanseCredit.shared.getItemCredit()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
        
    }
    
    func configure() {
        paymentSchaduleButton.layer.cornerRadius = 24
        addCostButton.layer.cornerRadius = 26
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func paymentAction(_ sender: Any) {
    }
    
    @IBAction func addAction(_ sender: Any) {
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
