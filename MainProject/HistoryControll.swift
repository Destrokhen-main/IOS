//
//  HistoryControll.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 19.12.2021.
//

import UIKit

class HistoryView: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        title = "История"
    }
    
    var tableArray:Array<ItemHistory> = [
        ItemHistory(data: "12.12.1212 23:59:21", count: 5),
        ItemHistory(data: "12.01.1212 23:59:21", count: 4),
        ItemHistory(data: "12.02.1212 23:59:21", count: 3),
        ItemHistory(data: "12.03.1212 23:59:21", count: 2)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        let req = requestFile()
        
        req.requestPOSTJson(url: "http://localhost/ios/getHistory.php", parametr: ["id" : Singletone.shared.idUser!]) { [weak self] (result) in
            switch result {
               case .success(let json):
                   DispatchQueue.main.async {
                       //self?.tableArray = json;
                   }
               case .failure(let error):
                   print("error:", error)
           }
        }
    }
}

extension HistoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
    }
}

extension HistoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Дата: " + tableArray[indexPath.row].data + " | Count: " + String(tableArray[indexPath.row].count);
        return cell
    }
}

struct ItemHistory: Decodable {
    var data: String
    var count: Int
}
