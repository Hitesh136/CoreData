//
//  ViewController.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users: [User] = [] {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
    }

    func delete(user: User) {
        appDelegate.persistentContainer.viewContext.delete(user)
        try? appDelegate.persistentContainer.viewContext.save()
    }
    
    func fetchUsers() {
        let fetchRequest: NSFetchRequest<User> = NSFetchRequest(entityName: "User")
        do {
            users = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Fetch Failed: \(error)")
        }
    }
    
    @IBAction func actionAdd() {
        if let userViewController = storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController {
            self.navigationController?.pushViewController(userViewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(user: users[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            delete(user: users[indexPath.row])
            fetchUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.userId = user.id
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
}
