//
//  TaskSmallCell.swift
//  KoviDorro
//
//  Created by Влад Мади on 30.12.2019.
//  Copyright © 2019 Влад Мади. All rights reserved.
//

import UIKit

class TaskSmallCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.cardView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.8002929688)
        self.cardView.layer.cornerRadius = 15
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
