//
//  DetailViewController.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userId: Int16?
    var field: [Detail] = []
    var tempContext: NSManagedObjectContext? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        tempContext?.automaticallyMergesChangesFromParent = true
        tempContext?.parent = appDelegate.persistentContainer.viewContext
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func actionSave(_ sender: Any) {
        
        do {
            try self.tempContext?.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        appDelegate.saveContext() 
        navigationController?.popViewController(animated: true)
    }
    
    func fetchFields() {
        
        let fetchrequest: NSFetchRequest<User> = NSFetchRequest(entityName: "User")
        let predicate = NSPredicate(format: "id == \(userId)")
        fetchrequest.predicate = predicate
        
        let sortDescripter = NSSortDescriptor(key: "price", ascending: true)
        fetchrequest.sortDescriptors = [sortDescripter]
        do {
            if let user = try tempContext?.fetch(fetchrequest).first, let detailSet = user.detail, let fieldArr = Array(detailSet) as? [Detail] {
                self.field = fieldArr
                self.tableView.reloadData()
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return field.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTextFieldTableVIewCell") as? SingleTextFieldTableVIewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configureCell(data: field[indexPath.row].name ?? "", index: indexPath.row)
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: SingleTextFieldTableViewCellDelegate {
    func passBackDate(string: String, index: Int) {
        field[index].name = string
    }
}

