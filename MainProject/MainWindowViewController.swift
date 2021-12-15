//
//  MainWindowViewController.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 14.11.2021.
//

import UIKit

class MainWindowViewController: UIViewController {
    
    let req = requestFile()
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var Score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGame();
    }
    
    func createGame() -> Void {
        req.requestPOST(url: "http://localhost/ios/game.php", parametr: ["id": Singletone.shared.idUser!]) { [weak self] (result) in
            switch result {
                case .success(let json):
                    DispatchQueue.main.async {
                        self?.Score.text = "Счёт : 0";
                        let one = json["one"] as! String;
                        let two = json["two"] as! String;
                        self?.Button1.setTitle(one, for: .normal);
                        self?.Button1.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                        self?.Button1.setNeedsDisplay()
                        self?.Button2.setTitle(two, for: .normal);
                        self?.Button2.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                        self?.Button2.setNeedsDisplay();
                    }
                case .failure(let error):
                    print("error:", error)
            }
        }
    }
    
    
    @IBAction func Button1(_ sender: Any) {
        req.requestPOST(url: "http://localhost/ios/game.php", parametr: ["answer": "0"]) { [weak self] (result) in
            switch result {
                case .success(let json):
                    DispatchQueue.main.async {
                        if (json["status"] as? Int == 200) {
                            let score = json["score"] as! String;
                            self?.Score.text = "Счёт : " + score;
                            let one = json["one"] as! String;
                            let two = json["two"] as! String;
                            self?.Button1.setTitle(one, for: .normal);
                            self?.Button2.setTitle(two, for: .normal);
                        } else if (json["status"] as? Int == 300) {
                            self?.Score.text = "Счёт : 0";
                            self?.createGame();
                            self?.showAlert(title: "Ошибка", text: "Вы не угадали");
                        }
                    }
                case .failure(let error):
                    print("error:", error)
            }
        }
    }
    
    @IBAction func Button2(_ sender: Any) {
        req.requestPOST(url: "http://localhost/ios/game.php", parametr: ["answer": "1"]) { [weak self] (result) in
            switch result {
                case .success(let json):
                    DispatchQueue.main.async {
                        if (json["status"] as? Int == 200) {
                            let score = json["score"] as! String;
                            self?.Score.text = "Счёт : " + score;
                            let one = json["one"] as! String;
                            let two = json["two"] as! String;
                            self?.Button1.setTitle(one, for: .normal);
                            self?.Button1.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                            self?.Button2.setTitle(two, for: .normal);
                            self?.Button2.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                        } else if (json["status"] as? Int == 300) {
                            self?.Score.text = "Счёт : 0";
                            self?.createGame();
                            self?.showAlert(title: "Ошибка", text: "Вы не угадали");
                        }
                    }
                case .failure(let error):
                    print("error:", error)
            }
        }
    }
    
    func showAlert(title : String,text : String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ещё раз?", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Profile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Profile")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        title = "Что гуглят больше?"
    }
}
