//
//  LoginFormViewController.swift
//  Asq
//
//  Created by ALENA SHABALINA on 26.04.2021.
//

import UIKit

class LoginFormViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var LoginTextField: UITextField!
    @IBOutlet var PassTextField: UITextField!
    @IBOutlet var nextStep: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tap)
        
        nextStep.layer.cornerRadius = 5
        nextStep.backgroundColor = .blue

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "LoginSegue" else {
           return false
        }
            let isLoginPassCorrect = LoginTextField.text == "1" && PassTextField.text == "1"
          
        if isLoginPassCorrect {
            return true
        } else {
            showErrorAlert()
        }

        return false
    }
    
    private func showErrorAlert() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel) {[weak self]_ in
            self?.PassTextField.text = ""
            self?.LoginTextField.text = ""
        }
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
// Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
           
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
           
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
       
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

    @IBAction func go(_ sender: Any) {
       print("Button pressed")
        if LoginTextField.text == "1" && PassTextField.text == "1" {
            print("Ok")
        } else {
            print("No")
        }
    }
}
