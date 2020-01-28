//
//  MenuViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 15.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func toggleSettings()
}

class MenuViewController: UIViewController {

    var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        delegate?.toggleSettings()
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        performSegue(withIdentifier: "FromMainToHistory", sender: nil)
        
    }
    


}
