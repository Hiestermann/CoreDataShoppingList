//
//  ItemsController.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit
import CoreData

class ItemsController: UITableViewController {
    
    var shop: Shop?
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = shop?.name
        
        tableView.backgroundColor = .slBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        setupPlusButtonInNavBar(selector: #selector(handleAddItem))
        
        fetchItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .slBlue
        cell.textLabel?.text = items[indexPath.item].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return items.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "List is empty"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let company = self.items[indexPath.row]
            
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            context.delete(company)
            
            do {
                try context.save()
            }catch let saveErr {
                print("Failed to delete company: ", saveErr)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        presentCreateItemController(item: items[indexPath.row])
    }
    
    private func presentCreateItemController(item: Item? = nil) {
        let createItemController = CreateItemController()
        createItemController.delegate = self
        createItemController.shop = shop
        createItemController.item = item
        let navController = CustomNavigationController(rootViewController: createItemController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchItems () {
        guard let shopItems = shop?.items?.allObjects as? [Item] else { return }

        items = shopItems
    }
    
    @objc private func handleAddItem() {
        presentCreateItemController()
        
    }
}
