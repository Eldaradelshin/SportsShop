//
//  Utils.swift
//  SportsShop
//
//  Created by rushan adelshin on 29.07.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

class Utils {
    
    class func currencyStringFromNumber(number:Double) -> String {
        let formatter = NumberFormatter()
        let modifiedNumber = NSNumber(floatLiteral: number)
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: modifiedNumber) ?? ""
        
    }
}
