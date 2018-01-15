//
//  ShopCell.swift
//  CoreDataShoppingList
//
//  Created by Kilian on 14.01.18.
//  Copyright © 2018 Kilian. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {
    
  
    
    var shop: Shop? {
        didSet {
            if let name = shop?.name{
                shopLabel.text = name
                
                if let numbItems = shop?.items?.count{
                    
                    itemsCoutLabel.text = "Items: \(numbItems)"
                }
            }
        }
    }

    private let shopLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop Name"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var itemsCoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop Name"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(shopLabel)
        shopLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        shopLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        
        addSubview(itemsCoutLabel)
        itemsCoutLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        itemsCoutLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
