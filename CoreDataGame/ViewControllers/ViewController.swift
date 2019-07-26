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
    var products: [Product] = [] {
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
        fetchProducts()
    }

    func delete(product: Product) {
        appDelegate.persistentContainer.viewContext.delete(product)
        try? appDelegate.persistentContainer.viewContext.save()
    }
    
    func fetchProducts() {
        let fetchRequest: NSFetchRequest<Product> = NSFetchRequest(entityName: "Product")
        do {
            products = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Fetch Failed: \(error)")
        }
    }
    
    @IBAction func actionAdd() {
        if let productViewController = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(product: products[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            delete(product: products[indexPath.row])
            fetchProducts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.field = Array(product.detail ?? []) as! [Detail]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
}
