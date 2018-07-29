//
//  Logger.swift
//  SportsShop
//
//  Created by rushan adelshin on 30.07.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

class Logger<T> where T:NSObject, T:NSCopying  {
    var dataItems:[T] = []
    var callback:(T) -> Void
    
    init(callback:@escaping (T)-> Void ) {
        self.callback = callback
    }
    
    func logItem(item:T) {
        dataItems.append(item.copy() as! T)
        callback(item)
    }
    
    func processItems(callback:(T) -> Void) {
        for item in dataItems {
            callback(item)
        }
    }
}
