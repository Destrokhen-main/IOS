//
//  ProfileView.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 01.12.2021.
//

import UIKit

class ProfileView: UIViewController {
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var bestscoreOutlet: UILabel!
    
    func load() {
        let req = requestFile()
        
        req.requestPOST(url: "http://localhost/ios/getinfo.php", parametr: ["id" : Singletone.shared.idUser!]) { [weak self] (result) in
            switch result {
               case .success(let json):
                   DispatchQueue.main.async {
                       let name = json["name"] as! String;
                       let score = json["score"] as! String;
                       
                       self?.nameOutlet.text = "Имя : " + name
                       self?.bestscoreOutlet.text = "Лучший счёт : " + score
                   }
               case .failure(let error):
                   print("error:", error)
           }
        }
    }
    
    @IBAction func HostoryButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "History")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func exit(_ sender: Any) {
        Singletone.shared.idUser = nil;
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "LogWindow")
        let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
        navigationController?.viewControllers = [secondVC]
        self.dismiss(animated: true, completion: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        title = "Профиль"
    }
}
