//
//  HomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift


class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    private var expance = Persistence.shared.getItemsExpance()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
        self.configure()
        getReload()
    }
    
    private func configure() {
        addCategoryButton.layer.cornerRadius = 24
    }
    
    private func configureTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func getReload() {
        let realm = try! Realm()
        let income = realm.objects(ExpanceData.self)
        Observable.array(from: income)
            .subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }
   
    @IBAction func addCategoryAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddIncomeViewController") as! AddIncomeViewController
        vc.index = 1
        present(vc, animated: true, completion: nil)
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
        let nameCategory = expance[indexPath.row].expance
        let index = expance[indexPath.row]
        vc.titleCat = nameCategory
        vc.index = index
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalTransitionStyle = .crossDissolve
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }


}
