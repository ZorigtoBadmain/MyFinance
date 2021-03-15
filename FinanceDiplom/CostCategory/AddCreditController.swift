//
//  AddCreditController.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 07.03.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class AddCreditController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var summaLabel: UILabel!
    @IBOutlet weak var summaTextField: UITextField!
    @IBOutlet weak var nameCloseButton: UIButton!
    @IBOutlet weak var summaCloseButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    var nameCategory: String?
    var index: ExpanceData?
    
    var creditOne = ExpanceData()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        closeButtonAction()
        buttonActivation()
        setupNotification()
        
        
    }
    
    func configure() {
        nameTextField.placeholder = "Наименование"
        nameTextField.keyboardType = .default
        nameTextField.becomeFirstResponder()
        summaTextField.placeholder = "Сумма"
        summaTextField.keyboardType = .decimalPad
        addButton.layer.cornerRadius = 24
        
    }
    
    func closeButtonAction() {
        nameCloseButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.nameTextField.text = ""
            self?.nameCloseButton.isHidden = true
            self?.addButton.isEnabled = false
            self?.addButton.alpha = 0.1
            self?.nameLabel.isHidden = true
        }).disposed(by: disposeBag)
        
        summaCloseButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.summaTextField.text = ""
            self?.nameCloseButton.isHidden = true
            self?.addButton.isEnabled = false
            self?.addButton.alpha = 0.1
            self?.summaLabel.isHidden = true
            
        }).disposed(by: disposeBag)
    }
    
    func buttonActivation() {
        let nameValid: Observable<Bool> = nameTextField.rx.text.map { (summa) -> Bool in
            summa!.count > 0
        }
        
        let nameInt: Observable<Bool> = nameTextField.rx.text.map { (income) -> Bool in
            self.validateName(candidate: income!)
        }
        
        let creditValid: Observable<Bool> = summaTextField.rx.text.map { (summa) -> Bool in
            summa!.count > 0
        }
        
        let creditInt: Observable<Bool> = summaTextField.rx.text.map { (income) -> Bool in
            self.validateCredit(candidate: income!)
        }
        
        Observable.combineLatest(nameValid, nameInt, creditValid, creditInt)
            .subscribe(onNext: { summa, number, name, credit in
                if (summa, number, name, credit) == (true, true, true, true) {
                    
                    self.addButton.isEnabled = true
                    self.addButton.alpha = 1
                    
                } else {
                    
                    self.addButton.isEnabled = false
                    self.addButton.alpha = 0.1
                    
                }
                if (summa, number) == (true, true) {
                    self.nameCloseButton.isHidden = false
                    self.nameLabel.isHidden = false
                } else {
                    self.nameCloseButton.isHidden = true
                    self.nameLabel.isHidden = true
                }
                
                if (name, credit) == (true, true) {
                    self.summaCloseButton.isHidden = false
                    self.summaLabel.isHidden = false
                } else {
                    self.summaCloseButton.isHidden = true
                    self.summaLabel.isHidden = true
                }
                
            }).disposed(by: disposeBag)
    }
    
    func validateName(candidate: String) -> Bool {
        let doubleRegex = "^[а-я0-9_]+$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", doubleRegex)
        return numberTest.evaluate(with: candidate)
    }
    
    func validateCredit(candidate: String) -> Bool {
        let doubleRegex = "^[0-9]*[,.]?[0-9]+$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", doubleRegex)
        return numberTest.evaluate(with: candidate)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let name = nameTextField.text ?? ""
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatteddate = formatter.string(from: time as Date)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        let num = numberFormatter.number(from: self.summaTextField.text ?? "")
        
        if let number = num{
            let floatNum = Float(truncating: number)
            
            let cred = Credit(name: name, date: formatteddate, number: floatNum)
            print(creditOne.expance)
            
            try! realm.write {
                if let index = index {
                    index.creditBuy.append(cred)
                    
                    realm.add(index)
                }
                
                print(realm.objects(ExpanceData.self))
            }
        }
        dismiss(animated: true, completion: nil)
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
