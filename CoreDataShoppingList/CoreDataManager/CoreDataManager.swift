//
//  CoreDataManager.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingData")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchShops () ->[Shop] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Shop>(entityName: "Shop")
        do{
            let shops = try context.fetch(fetchRequest)
            return shops
        }catch let fetchErr {
            print(fetchErr)
        }
        return[]
    }
}
