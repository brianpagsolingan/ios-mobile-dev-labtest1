//
//  AppDelegate.swift
//  A2_IOS_brian_101490258
//
//  Created by Brian Aldrin Pagsolingan on 2026-04-02.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func preloadData() {
        let defaults = UserDefaults.standard
        
        // run once on first launc
        guard !defaults.bool(forKey: "dataLoaded") else {return}
        
        let context = persistentContainer.viewContext
        
        let products: [[String: Any]] = [
            ["id": 1, "name": "iPhone 17", "desc": "Apple smartphone", "price": 1999.99, "provider": "Apple"],
            ["id": 2, "name": "Samsung Galaxy S26 Ultra", "desc": "Samsung smartphone", "price": 1999.99, "provider": "Samsung"],
            ["id": 3, "name": "Pixel 10 Pro", "desc": "Google smartphone", "price": 1999.99, "provider": "Google"]
        ]
        
        for p in products{
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
            entity.setValue(p["id"], forKey: "productID")
            entity.setValue(p["name"], forKey: "productName")
            entity.setValue(p["desc"], forKey: "productDescription")
            entity.setValue(p["price"], forKey: "productPrice")
            entity.setValue(p["provider"], forKey: "productProvider")
        }
        
        do{
            try context.save()
            defaults.set(true, forKey: "dataLoaded")
            print("sample data dloaded")
        }catch{
            print("failed to load sample data \(error)")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "A2_IOS_brian_101490258")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

