//
//  ViewController.swift
//  A2_IOS_brian_101490258
//
//  Created by Brian Aldrin Pagsolingan on 2026-04-02.
//

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProvider: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var products: [NSManagedObject] = []
    var currentIndex = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Product Viewer"
        searchBar.delegate = self
        fetchProducts()
    }
    
    func fetchProducts(filter: String = ""){
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        request.sortDescriptors = [NSSortDescriptor(key: "productID", ascending: true)]
        
        if !filter.isEmpty {
            request.predicate = NSPredicate(
                format: "productName CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@", filter, filter
            )
        }
        
        do {
            products = try context.fetch(request)
            currentIndex = 0
            showProduct()
        }catch{
            print("Error fetching data: \(error)")
        }
    }
    
    func showProduct(){
        guard !products.isEmpty else {
            lblID.text = "No products found"
            lblName.text = ""
            lblDesc.text = ""
            lblPrice.text = ""
            lblProvider.text = ""
            return
        }
        
        let p = products[currentIndex]
        lblID.text = p.value(forKey: "productID") as? String
        lblName.text = p.value(forKey: "productName") as? String
        lblDesc.text = p.value(forKey: "productDescription") as? String
        
        if let price = p.value(forKey: "productPrice") as? Double {
            lblPrice.text = String(format: "$%.2f", price)
        }
        
        lblProvider.text = p.value(forKey: "productProvider") as? String
    }


}

