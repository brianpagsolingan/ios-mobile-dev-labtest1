//
//  AddProductViewController.swift
//  A2_IOS_brian_101490258
//
//  Created by Brian Aldrin Pagsolingan on 2026-04-03.
//

import UIKit
import CoreData

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtProvider: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Product"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        // validation
        guard let name = txtName.text, !name.isEmpty,
              let desc = txtDescription.text, !desc.isEmpty,
              let priceText = txtPrice.text, let price = Double(priceText),
              let provider = txtProvider.text, !provider.isEmpty
        else{
            showAlert(message: "Please fill in all fields correctly")
            return
        }
        
        // autogenerate ID
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        let count = (try? context.fetch(request).count) ?? 0
        let newID = count + 1
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
        entity.setValue(newID, forKey: "productID")
        entity.setValue(name, forKey: "productName")
        entity.setValue(desc, forKey: "productDescription")
        entity.setValue(price, forKey: "productPrice")
        entity.setValue(provider, forKey:   "productProvider")
        
        do{
            try context.save()
            print("Product saved: \(name)")
            navigationController?.popViewController(animated: true)
        } catch{
            showAlert(message: "Failed to save")
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
