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

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        delegate?.toggleSettings()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
