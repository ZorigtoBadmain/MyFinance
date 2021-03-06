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
    
    @IBOutlet weak var summaLabel: UILabel!
    @IBOutlet weak var addIncometextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var bottomConstarain: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    private var income = Income()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        if index == 0 {
            configureIncome()
            buttonIncomeActivation()
        } else {
            configureExpance()
            buttonExpanceActivation()
        }
        
        closeButtonAction()
        setupNotification()
    }
    
    private func configure() {
        addIncometextField.becomeFirstResponder()
        addButton.layer.cornerRadius = 24
    }
    
    private func configureIncome() {
        addIncometextField.placeholder = "Сумма"
        addIncometextField.keyboardType = .decimalPad
        
    }
    
    private func configureExpance() {
        addIncometextField.placeholder = "Наименование"
        addIncometextField.keyboardType = .default
    
    }
    
    private func closeButtonAction() {
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.addIncometextField.text = ""
            self?.closeButton.isHidden = true
            self?.addButton.isEnabled = false
            self?.summaLabel.isHidden = true
            self?.addButton.alpha = 0.1
        }).disposed(by: disposeBag)
    }
    
    private func buttonIncomeActivation() {
        let incomeValid: Observable<Bool> = addIncometextField.rx.text.map { (summa) -> Bool in
            summa!.count > 0
        }
        
        let incomeInt: Observable<Bool> = addIncometextField.rx.text.map { (income) -> Bool in
            self.validateIncome(candidate: income!)
        }
        
        Observable.combineLatest(incomeValid, incomeInt)
            .subscribe(onNext: { summa, number in
                if (summa, number) == (true, true) {
                    self.closeButton.isHidden = false
                    self.addButton.isEnabled = true
                    self.addButton.alpha = 1
                    self.summaLabel.isHidden = false
                } else {
                    self.closeButton.isHidden = true
                    self.addButton.isEnabled = false
                    self.addButton.alpha = 0.1
                    self.summaLabel.isHidden = true
                }
                
            }).disposed(by: disposeBag)
    }
    
    private func buttonExpanceActivation() {
        let incomeValid: Observable<Bool> = addIncometextField.rx.text.map { (summa) -> Bool in
            summa!.count > 0
        }
        
        let incomeInt: Observable<Bool> = addIncometextField.rx.text.map { (income) -> Bool in
            self.validateExpance(candidate: income!)
        }
        
        Observable.combineLatest(incomeValid, incomeInt)
            .subscribe(onNext: { summa, number in
                if (summa, number) == (true, true) {
                    self.closeButton.isHidden = false
                    self.addButton.isEnabled = true
                    self.addButton.alpha = 1
                    self.summaLabel.isHidden = false
                } else {
                    self.closeButton.isHidden = true
                    self.addButton.isEnabled = false
                    self.addButton.alpha = 0.1
                    self.summaLabel.isHidden = true
                }
                
            }).disposed(by: disposeBag)
    }
    
    private func validateIncome(candidate: String) -> Bool {
        let doubleRegex = "^[0-9]*[,.]?[0-9]+$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", doubleRegex)
        return numberTest.evaluate(with: candidate)
    }
    
    private func validateExpance(candidate: String) -> Bool {
        let doubleRegex = "^[а-я]+$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", doubleRegex)
        return numberTest.evaluate(with: candidate)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        addIncometextField.text = ""
    }
    
    @IBAction func addIncomeAction(_ sender: Any) {

        if index == 0 {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        let num = numberFormatter.number(from: self.addIncometextField.text ?? "")
        if let number = num{
            
            income.getIncome(income: Float(truncating: number))
            Persistence.shared.saveIncome(item: income)
        }
        dismiss(animated: true)
        } else {
            let expan = addIncometextField.text ?? ""
            let exp = ExpanceData(expance: expan)
            Persistence.shared.saveExpance(item: exp)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        bottomConstarain.constant = keyboardFrame.height
    }
    
    @objc func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        } 

    }
}
