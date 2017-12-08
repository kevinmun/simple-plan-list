//
//  Plan.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation

enum PlanType: Int {
    case Important = 0
    case SemiImportant
    case Normal
    case Trivial
}
struct Plan {
    let title: String
    let imageUrl: String
    let type: PlanType
    
    init(title: String,
         imageUrl: String,
         type: PlanType) {
        self.title = title
        self.imageUrl = imageUrl
        self.type = type
    }
}
