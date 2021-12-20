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
    
    var tableArray:[requestFile.ItemHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        let req = requestFile()
        
        req.requestPOSTJson(url: "http://localhost/ios/getHistory.php", parametr: ["id" : Singletone.shared.idUser!]) { [weak self] (result) in
            switch result {
               case .success(let json):
                   DispatchQueue.main.async {
                       print(json)
                       self?.tableArray = json;
                       self?.TableView.reloadData()
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
