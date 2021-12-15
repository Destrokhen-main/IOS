//
//  RegistartionView.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 28.11.2021.
//

import UIKit

class RegistartionView: UIViewController {
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var PasswordField1: UITextField!
    
    
    @IBAction func CreateAcc(_ sender: Any) {
        
        let req = requestFile()
        
        let NameField = NameField.text!
        let loginField = loginField.text!
        let password = PasswordField.text!
        let password1 = PasswordField1.text!
        
        if (!NameField.isEmpty && !loginField.isEmpty && !password.isEmpty && !password1.isEmpty) {
            if (password == password1) {
                req.requestPOST(url: "http://localhost/ios/registration.php", parametr: ["login":loginField,"name":NameField, "password":password]) { [weak self] (result) in
                     switch result {
                        case .success(let json):
                            DispatchQueue.main.async {
                                if (json["status"] as? Int == 200) {
                                    Singletone.shared.idUser = json["id"] as! String
                                    
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let secondVC = storyboard.instantiateViewController(identifier: "MainWindow")
                                    let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
                                    navigationController?.viewControllers = [secondVC]
                                    self?.dismiss(animated: true, completion: .none)
                                    
                                } else {
                                    self?.showAlert(title: "Ошибка" ,text: json["message"] as! String)
                                }
                            }
                        case .failure(let error):
                            print("error:", error)
                    }
                }
            } else {
                showAlert(title: "Ошибка", text: "Пароли не совпадают")
            }
        } else {
            showAlert(title: "Ошибка", text: "Нужно заполнить поля")
        }
        
    }
    
    func showAlert(title : String,text : String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
