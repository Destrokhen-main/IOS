//
//  ViewController.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 02.11.2021.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginForm(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func RegistrationForm(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Registration")
        self.present(vc!, animated: true, completion: nil)
    }
}

@IBDesignable
extension UIView {

    @IBInspectable
    var radius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}


final class Singletone {
    static var shared = Singletone()
    
    private init() {}
    
    var idUser : String?
}
