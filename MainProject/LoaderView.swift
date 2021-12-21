//
//  LoaderView.swift
//  MainProject
//
//  Created by Vladislav Pyslar on 21.12.2021.
//

import UIKit

class LoaderView: UIViewController {
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.startAnimating()
        Loader.hidesWhenStopped = true
    }
}
