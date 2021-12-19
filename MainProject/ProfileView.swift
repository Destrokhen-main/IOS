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
    
    
//    struct ItemHistory: Codable {
//        var date: String
//        var score: String
//
//        enum CodingKeys: String, CodingKey {
//            case date
//            case score
//        }
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            date = try container.decode(String.self, forKey: .date)
//            score = try container.decode(String.self, forKey: .score)
//        }
//    }
    
//    struct Product: Codable {
//      var title:String
//      var price:Double
//      var quantity:Int
//
//      enum CodingKeys: String, CodingKey {
//        case title
//        case price
//        case quantity
//      }
//      func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(title, forKey: .title)
//        try container.encode(price, forKey: .price)
//        try container.encode(quantity, forKey: .quantity)
//      }
//      init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        title = try container.decode(String.self, forKey: .title)
//        price = try container.decode(Double.self, forKey: .price)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//      }
//    }
}
