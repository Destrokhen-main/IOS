//
//  MainWindowViewController.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 14.11.2021.
//

import UIKit

class MainWindowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Profile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Profile")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
