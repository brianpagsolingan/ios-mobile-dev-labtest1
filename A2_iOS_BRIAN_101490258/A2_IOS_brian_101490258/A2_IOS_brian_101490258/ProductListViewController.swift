//
//  ProductListViewController.swift
//  A2_IOS_brian_101490258
//
//  Created by Brian Aldrin Pagsolingan on 2026-04-03.
//

import UIKit
import CoreData

class ProductListViewController: UITableViewController {
    
    var products: [NSManagedObject] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Products"
        fetchProducts()

    }
    
    // MARK: - FETCHING
    
    func fetchProducts(){
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        request.sortDescriptors = [NSSortDescriptor(key: "productID", ascending: true)]
        do{
            products = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("fetch error \(error)")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let p = products[indexPath.row]
        
        cell.textLabel?.text = p.value(forKey: "productName") as? String
        cell.detailTextLabel?.text = p.value(forKey: "productDescription") as? String
        return cell
    }

    

}
