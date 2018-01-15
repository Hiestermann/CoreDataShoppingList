//
//  CreateItemController.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit
import CoreData

protocol ItemsControllerDelegate {
    func didAddItem(item: Item)
    func didEditItem(item: Item)
}

class CreateItemController: UIViewController {
    
    var shop: Shop?
    var item: Item? {
        didSet{
            if let name = item?.name {
                itemNameTextField.text = name
            }
        }
    }
    var delegate: ItemsControllerDelegate?
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.placeholder = "Name here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        view.backgroundColor = .slBlue
        navigationItem.title =  item == nil ? "New Item" : "Edit Item"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(handleSave))
        
        setupViews()
    }
    
    @objc func handleSave() {
        if item == nil {
            handleCreate()
        } else {
            handleEdit()
        }
    }
    
    private func handleEdit() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        item?.name = itemNameTextField.text
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditItem(item: self.item!)
            })
        }catch let saveErr {
            print("save failed", saveErr)
        }
    }
    
    private func handleCreate() {
        guard let name = itemNameTextField.text else { return }
        guard let shop = self.shop else { return }
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
        
        item.shop = shop
        item.bought = false
        item.setValue(name, forKey: "name")
        
        do{
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddItem(item: item)
                
            })
        }catch let saveErr {
            print("Failed to save", saveErr)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .slTeal
        
        view.addSubview(backgroundView)
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        view.addSubview(itemNameLabel)
        itemNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        itemNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        itemNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemNameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        view.addSubview(itemNameTextField)
        itemNameTextField.leftAnchor.constraint(equalTo: itemNameLabel.rightAnchor).isActive = true
        itemNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemNameTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
