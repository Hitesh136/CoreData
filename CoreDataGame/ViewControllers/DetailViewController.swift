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

    var field: [Detail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
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

