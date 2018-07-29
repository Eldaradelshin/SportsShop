//
//  ProductTableCell.swift
//  SportsShop
//
//  Created by rushan adelshin on 29.07.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    //var productId:Int?
    
    var product:Product?
 

    
}
