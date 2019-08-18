//
//  UserTableViewCell.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import UIKit
import CoreData

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(user: User) {
        fullNameLabel.text = user.name
        
        priceLabel.text = String(user.age)
    } 
}
