//
//  MainWindowViewController.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 14.11.2021.
//

import UIKit

class MainWindowViewController: UIViewController {
    
    let req = requestFile()
    
    let arrayColor = [
        UIColor(red: 0.85, green: 0.24, blue: 0.31, alpha: 1.00),
        UIColor(red: 0.80, green: 0.24, blue: 0.85, alpha: 1.00),
        UIColor(red: 0.33, green: 0.14, blue: 0.84, alpha: 1.00),
        UIColor(red: 0.14, green: 0.62, blue: 0.84, alpha: 1.00),
        UIColor(red: 0.14, green: 0.84, blue: 0.25, alpha: 1.00),
        UIColor(red: 0.84, green: 0.59, blue: 0.14, alpha: 1.00),
        UIColor(red: 0.84, green: 0.25, blue: 0.14, alpha: 1.00)
    ]
    
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
                        
                        var color1 = self?.arrayColor.randomElement()!;
                        let color2 = self?.arrayColor.randomElement()!;
                        
                        if (color1 == color2) {
                            color1 = self?.arrayColor.randomElement()!;
                        }
                        
                        self?.Button1.setTitle(one, for: .normal);
                        self?.Button1.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                        self?.Button1.setNeedsDisplay()
                        
                        self?.Button1.backgroundColor = color1;
                        
                        
                        self?.Button2.setTitle(two, for: .normal);
                        self?.Button2.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                        self?.Button2.setNeedsDisplay();
                        
                        self?.Button2.backgroundColor = color2;
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
                            
                            let color1 = self?.arrayColor.randomElement()!;
                            let color2 = self?.arrayColor.randomElement()!;
                            
                            self?.Button1.setTitle(one, for: .normal);
                            self?.Button1.backgroundColor = color1;
                            
                            
                            self?.Button2.setTitle(two, for: .normal);
                            self?.Button2.backgroundColor = color2;
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
