//
//  Logger.swift
//  SportsShop
//
//  Created by rushan adelshin on 30.07.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

let productLogger = Logger<Product> (callback: {p in
   
    var builder = ChangeRecordBuilder()
    builder.productName = p.name
    builder.category    = p.category
    builder.value       = String(p.stockLevel)
    builder.outerTag    = "stockChange"
    
    var changeRecord = builder.changeRecord
    if (changeRecord != nil) {
        print(builder.changeRecord!.description)
    }
    
    
})

final class Logger<T> where T:NSObject, T:NSCopying  {
    
    var dataItems:[T] = []
    var callback:(T) -> Void
    var arrayQ = DispatchQueue.init(label: "arrayQ")
    var callbackQ = DispatchQueue.init(label: "callbackQ")
    

    
   fileprivate init(callback: @escaping (T)-> Void, protect:Bool = true) {
        self.callback = callback
        if (protect) {
            self.callback = {(item:T) in
                self.callbackQ.sync {
                    () in callback(item)
                }
            }
        }
    }
    
    func logItem(item:T) {
        arrayQ.async {
            () in
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
}
    
    func processItems(callback:(T) -> Void) {
        
        arrayQ.sync {
        for item in dataItems {
            callback(item)
        }
        }
}
}
