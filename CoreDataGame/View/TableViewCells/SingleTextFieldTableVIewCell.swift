//
//  SingleTextFieldTableVIewCell.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import UIKit

protocol SingleTextFieldTableViewCellDelegate: AnyObject{
    func passBackDate(string: String, index: Int)
}

class SingleTextFieldTableVIewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    weak var delegate: SingleTextFieldTableViewCellDelegate?
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    func configureCell(data: String, index: Int) {
        textField.text = data
        self.index = index
    }
}

extension SingleTextFieldTableVIewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.passBackDate(string: textField.text ?? "", index: index)
    }
}
