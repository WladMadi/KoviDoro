//
//  MainCell.swift
//  KoviDorro
//
//  Created by Влад Мади on 13.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    
    //Тот же ViewDidLoad но для View
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellSettings()
        
    }
    
    
    //Настройки ячейки
    func cellSettings() {
        let cellSize = self.frame.size.width
        
        imageView.frame.size.height = cellSize
        imageView.frame.size.width = cellSize
    }
    
}
