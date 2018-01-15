//
//  ViewController.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListController: UITableViewController{
    
    var shops = [Shop]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shops = CoreDataManager.shared.fetchShops()
        
        navigationItem.title = "Shops"
        view.backgroundColor = .slBlue
        tableView.register(ShopCell.self, forCellReuseIdentifier: "cellID")
        setupPlusButtonInNavBar(selector: #selector(createShop))
    }

    @objc private func createShop () {
        let createShopController = CreateShopController()
        createShopController.delegate = self
        let navController = CustomNavigationController(rootViewController: createShopController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ShopCell
        
        if(indexPath.row % 3 == 0) {
            cell.backgroundColor = .slPurble
        } else if(indexPath.row % 2 == 0) {
            cell.backgroundColor = .slRed
        } else {
            cell.backgroundColor = .slGreen
        }
        
        cell.shop = shops[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemController = ItemsController()
        let shop = self.shops[indexPath.row]
        itemController.shop = shop
        navigationController?.pushViewController(itemController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return shops.count == 0 ? 150 : 0
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
            let company = self.shops[indexPath.row]
            
            self.shops.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            context.delete(company)
            
            do {
                try context.save()
            }catch let saveErr {
                print("Failed to delete company: ", saveErr)
            }
        }
        return [deleteAction]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

