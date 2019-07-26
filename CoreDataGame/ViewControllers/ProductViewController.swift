//
//  DetailsViewController.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import UIKit
import CoreData

class ProductViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionSave() {
        saveProductInDB()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveProductInDB() {
        let product = Product(context: appDelegate.persistentContainer.viewContext)
        product.name = nameTextField.text
        product.price = Int16(priceTextField.text ?? "") ?? 0
        product.setDefaultDetail()
        do {
            try appDelegate.persistentContainer.viewContext.save()
            print("Product saved in Database.")
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
    } 
}

