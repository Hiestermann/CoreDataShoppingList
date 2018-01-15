//
//  ItemsController+CreateItemDelegate.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit

extension ItemsController: ItemsControllerDelegate {
    func didEditItem(item: Item) {
        let row = items.index(of: item)
        let relodIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [relodIndexPath], with: .middle)
    }
    
    func didAddItem(item: Item) {
        items.append(item)

        let newIndexPath = IndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
}
