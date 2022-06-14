//
//  TempViewController.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/14/22.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let vc = CryptoList.createModule(){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
