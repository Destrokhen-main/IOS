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
        let req = requestFile()
        let loginField = LoginField.text!
        let passwordField = PasswordField.text!
        
        if (!loginField.isEmpty && !passwordField.isEmpty) {
            req.requestPOST(url: "http://localhost/ios/auth.php", parametr: ["login":loginField,"password":passwordField]) { [weak self] (result) in
                switch result {
                   case .success(let json):
                       DispatchQueue.main.async {
                           print(json)
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
            showAlert(title: "Ошибка", text: "Заполните поля!")
        }
    }
    
    func showAlert(title: String, text : String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
