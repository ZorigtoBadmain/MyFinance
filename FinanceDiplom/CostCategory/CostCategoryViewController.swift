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
    

}

extension CostCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostCell", for: indexPath) as! CostCell
        cell.money.text = "10000 Р"
        cell.nameCategory.text = "ЖКХ"
        cell.date.text = "23.04.18"
        
        return cell
    }
    
    
}
