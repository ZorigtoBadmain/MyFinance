//
//  HomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    let category = ["Дом", "Продукты", "Досуг", "Постоянные траты", "Путешествия"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
    }
    
    func configure() {
        addCategoryButton.layer.cornerRadius = 24
    }
    
    func configureTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
   
    @IBAction func addCategoryAction(_ sender: UIButton) {
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.textLabel?.text = category[indexPath.row]
        return cell
    }
    
    
}
