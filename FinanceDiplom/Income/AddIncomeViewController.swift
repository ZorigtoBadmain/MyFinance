//
//  AddIncomeViewController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 23.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class AddIncomeViewController: UIViewController {
    
    @IBOutlet weak var summatextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var income = IncomeData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        buttonActivation()
        closeButtonAction()
    }
    
    func configure() {
        summatextField.placeholder = "Сумма"
        summatextField.keyboardType = .numberPad
        summatextField.becomeFirstResponder()
        addButton.layer.cornerRadius = 24
    }
    
    func closeButtonAction() {
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.summatextField.text = ""
            self?.closeButton.isHidden = true
            self?.addButton.isEnabled = false
            self?.addButton.alpha = 0.1
        }).disposed(by: disposeBag)
    }
    
    func buttonActivation() {
        let incomeValid: Observable<Bool> = summatextField.rx.text.map { (summa) -> Bool in
            summa!.count > 0
        }
        
        let incomeInt: Observable<Bool> = summatextField.rx.text.map { (income) -> Bool in
            self.validateIncome(candidate: income!)
        }
        
        Observable.combineLatest(incomeValid, incomeInt)
            .subscribe(onNext: { summa, number in
                if (summa, number) == (true, true) {
                    self.closeButton.isHidden = false
                    self.addButton.isEnabled = true
                    self.addButton.alpha = 1
                } else {
                    self.closeButton.isHidden = true
                    self.addButton.isEnabled = false
                    self.addButton.alpha = 0.1
                }
                
            }).disposed(by: disposeBag)
    }
    
    func validateIncome(candidate: String) -> Bool {
        let PHONE_REGEX = "\\d{1,10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return numberTest.evaluate(with: candidate)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        summatextField.text = ""
    }
    
    @IBAction func addIncomeAction(_ sender: Any) {
        let number = Int(self.summatextField.text ?? "")
        if let number = number{
            
            income.getIncome(income: number)
            Persistence.shared.save(item: income)
        }
        
    }
}
