//
//  ShopListController+CreateShopDelegate.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit

extension ShoppingListController: CreateShopControllerDelegate {
    func didAddShop(shop: Shop) {
        shops.append(shop)
        
        let newIndexPath = IndexPath(row: shops.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
}
