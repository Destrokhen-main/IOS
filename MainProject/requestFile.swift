//
//  requestFile.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 29.11.2021.
//

import Foundation

class requestFile {
    func requestPOST (url: String, parametr: [String: String], completion: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        let par = parametr
        var requet = URLRequest(url: url)
        requet.httpMethod = "POST"
        requet.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: par, options: []) else {return}
        requet.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: requet) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                completion(.success(json))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
