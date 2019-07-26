//
//  Product+Helper.swift
//  CoreDataGame
//
//  Created by Hitesh Agarwal on 26/07/19.
//  Copyright © 2019 Finoit Technologies. All rights reserved.
//

import Foundation

extension Product {
    func setDefaultDetail() {
        let context = appDelegate.persistentContainer.viewContext
        let d1 = Detail(context: context)
        d1.name = "one"
        let d2 = Detail(context: context)
        d2.name = "two"
        let d3 = Detail(context: context)
        d3.name = "three"
        let d4 = Detail(context: context)
        d4.name = "four"
        let d5 = Detail(context: context)
        d5.name = "five"
        let d6 = Detail(context: context)
        d6.name = "six"
        let d7 = Detail(context: context)
        d7.name = "saven"
        let d8 = Detail(context: context)
        d8.name = "eight"
        let d9 = Detail(context: context)
        d9.name = "nine"
        let d10 = Detail(context: context)
        d10.name = "ten"
        let d11 = Detail(context: context)
        d11.name = "eleven"
        let d12 = Detail(context: context)
        d12.name = "twelve"
        
        detail = [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12] 
    }
}
