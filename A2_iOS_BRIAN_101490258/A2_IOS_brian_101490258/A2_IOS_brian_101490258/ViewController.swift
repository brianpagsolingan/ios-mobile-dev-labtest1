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
        searchBar.showsCancelButton = true
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }
    // MARK: FETCH
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
    
    // MARK: SHOW PRODUCT
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
        if let id = p.value(forKey: "productID") as? Int64 {
            lblID.text = "\(id)"
        }
        lblName.text = p.value(forKey: "productName") as? String
        lblDesc.text = p.value(forKey: "productDescription") as? String
        
        if let price = p.value(forKey: "productPrice") as? Double {
            lblPrice.text = String(format: "$%.2f", price)
        }
        
        lblProvider.text = p.value(forKey: "productProvider") as? String
    }
    
    // MARK: - NAVIGATION
    @IBAction func prevTapped(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            showProduct()
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if currentIndex < products.count - 1 {
            currentIndex += 1
            showProduct()
        }
    }
    
    // MARK: - Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        fetchProducts(filter: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        fetchProducts()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty {
            fetchProducts()
        }
    }
}

