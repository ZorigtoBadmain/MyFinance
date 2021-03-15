//
//  AddExpanceCategoryController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 07.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class AddExpanceCategoryController: UIViewController {

    @IBOutlet weak var summaLabel: UILabel!
    @IBOutlet weak var expanceTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addExpanceButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    var expance = ExpanceData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        closeButtonAction()
        buttonActivation()
        setupNotification()
        
    }
    
    func configure() {
        expanceTextField.placeholder = "Наименование"
        expanceTextField.keyboardType = .default
        expanceTextField.becomeFirstResponder()
        addExpanceButton.layer.cornerRadius = 24
    }
    
    func closeButtonAction() {
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.expanceTextField.text = ""
            self?.closeButton.isHidden = true
            self?.addExpanceButton.isEnabled = false
            self?.addExpanceButton.alpha = 0.1
            self?.summaLabel.isHidden = true
        }).disposed(by: disposeBag)
    }
    
    func buttonActivation() {
        let incomeValid: Observable<Bool> = expanceTextField.rx.text.map { (summa) -> Bool in
            summa!.count > 0
        }
        
        let incomeInt: Observable<Bool> = expanceTextField.rx.text.map { (income) -> Bool in
            self.validateIncome(candidate: income!)
        }
        
        Observable.combineLatest(incomeValid, incomeInt)
            .subscribe(onNext: { summa, number in
                if (summa, number) == (true, true) {
                    self.closeButton.isHidden = false
                    self.addExpanceButton.isEnabled = true
                    self.addExpanceButton.alpha = 1
                    self.summaLabel.isHidden = false
                } else {
                    self.closeButton.isHidden = true
                    self.addExpanceButton.isEnabled = false
                    self.addExpanceButton.alpha = 0.1
                    self.summaLabel.isHidden = true
                }
                
            }).disposed(by: disposeBag)
    }
    
    func validateIncome(candidate: String) -> Bool {
        let doubleRegex = "^[а-я0-9_]+$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", doubleRegex)
        return numberTest.evaluate(with: candidate)
    }
    
    @IBAction func closeAction(_ sender: Any) {
    }
    
    @IBAction func addAction(_ sender: Any) {
        let expan = expanceTextField.text ?? ""
        let exp = ExpanceData(expance: expan)
        Persistence.shared.saveExpance(item: exp)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        bottomConstraint.constant = keyboardFrame.height
    }
    
    @objc func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }

    }
    
}
