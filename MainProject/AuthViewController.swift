//
//  AuthViewController.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 14.11.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var LoginField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    
    @IBAction func LoginButton(_ sender: Any) {
        let loginField = LoginField.text!
        let passwordField = PasswordField.text!
        
        if (!loginField.isEmpty && !passwordField.isEmpty) {
            if (loginField == "Test") {
                if (passwordField == "123") {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "MainWindow")

//                    secondVC.modalPresentationStyle = .fullScreen
//                    secondVC.modalTransitionStyle = .crossDissolve
//
//                    present(secondVC, animated: true, completion: nil)
//
//
//                    self.dismiss(animated: true, completion: { [weak self] in
//                        print(self?.presentedViewController == nil)
//                        print(self?.presentingViewController == nil)
//                        print(self?.presentingViewController?.navigationController == nil)
//                        print(self?.presentedViewController?.navigationController == nil)
                        self.presentingViewController?.navigationController?.viewControllers = [secondVC]
//                    });
                    
                } else {
                    showAlert(text: "Пароль не тот!")
                }
            } else {
                showAlert(text: "Логин не тот!")
            }
        } else {
            showAlert(text: "Заполните поля!")
        }
    }
    
    func showAlert(text : String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
