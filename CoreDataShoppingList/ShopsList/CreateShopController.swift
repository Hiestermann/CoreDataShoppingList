//
//  CreateShopController.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit
import CoreData

protocol CreateShopControllerDelegate {
    func didAddShop(shop: Shop)
}

class CreateShopController: UIViewController {
    
    let shopNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shopNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.placeholder = "Name here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var delegate: CreateShopControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .slBlue
        
        setupCancelButton()
        
        navigationItem.title = "New Shop"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(handleSave))
        
        setupViews()
    }
    
    
    @objc private func handleSave() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let shop = NSEntityDescription.insertNewObject(forEntityName: "Shop", into: context)
        
        guard let name = self.shopNameTextField.text else { return }
        shop.setValue(name, forKey: "name")
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddShop(shop: shop as! Shop)
            })
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
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
        
        view.addSubview(shopNameLabel)
        shopNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        shopNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        shopNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shopNameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        view.addSubview(shopNameTextField)
        shopNameTextField.leftAnchor.constraint(equalTo: shopNameLabel.rightAnchor).isActive = true
        shopNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shopNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shopNameTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
