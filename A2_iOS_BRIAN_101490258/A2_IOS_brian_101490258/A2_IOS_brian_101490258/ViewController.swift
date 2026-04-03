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
    
    


}

