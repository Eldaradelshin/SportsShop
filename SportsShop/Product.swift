//
//  Product.swift
//  SportsShop
//
//  Created by rushan adelshin on 29.07.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying {
    
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: self.name, description: self.description, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
    private(set) var name: String
    private(set) var productDescription:String
    private(set) var category:String
    private var stockLevelBackingValue:Int = 0
    private var priceBackingValue:Double = 0
    
    var stockLevel:Int {
        get { return stockLevelBackingValue }
        set { stockLevelBackingValue = max(0, newValue)}
    }

    private(set) var price:Double {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue)}
    }

    var stockValue:Double {
        get {
            return price * Double(stockLevel)
        }
    }
    
    
    
    
    
    init(name:String, description:String, category:String, price:Double, stockLevel:Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        
        super.init()
        
        self.price = price
        self.stockLevel = stockLevel
    }
    
    
}



