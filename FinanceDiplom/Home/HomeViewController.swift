//
//  HomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    let category = ["Дом", "Продукты", "Досуг", "Постоянные траты", "Путешествия"]
    var expance = Persistence.shared.getItemsExpance()
    
//    let array = BehaviorRelay(value: ExpanceData.self)
//    let array2 = BehaviorRelay(value: Persistence.shared.getItemsExpance())
//    let array = BehaviorSubject(value: Persistence.shared.getItemsExpance())
//    let array = Observable<Any>(Persistence.shared.getItemsExpance())
    let disposeBag = DisposeBag()
    
    
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
    
//    func bindTableView() {
//        array.bind(to: tableView.rx.items) {
//            (tableView: UITableView, index: Int, element: String) in
//            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//            cell.textLabel?.text = element
//
//            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
//                tableView.deselectRow(at: selectedRowIndexPath, animated: true)
//            }
//            return cell
//        }
//        .disposed(by: disposeBag)
//    }
   
    @IBAction func addCategoryAction(_ sender: UIButton) {
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expance.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let item = expance[indexPath.row]
        cell.textLabel?.text = item.expance
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CostCategoryViewController") as! CostCategoryViewController
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalTransitionStyle = .crossDissolve
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }


}
