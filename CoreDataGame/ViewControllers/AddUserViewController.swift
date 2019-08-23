//
//  DetailsViewController.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import UIKit
import CoreData

class AddUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.becomeFirstResponder()
    }
    
    @IBAction func actionSave() {
        saveUserInDB()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveUserInDB() {
        let user = User(context: appDelegate.persistentContainer.viewContext)
        user.firstName = firstNameTextField.text
        user.lastName = lastNameTextField.text
        if let age = ageTextField.text, !age.isEmpty {
            user.age = Int16(age) ?? 0
        }
        
        if let gender = genderTextField.text, !gender.isEmpty {
            user.gender = gender
        }
        user.setDefaultDetail()
        user.id =  Int16.random(in: 0...1000)
        do {
            try appDelegate.persistentContainer.viewContext.save()
            print("User saved in Database.")
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
    } 
}

