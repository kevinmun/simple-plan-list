//
//  Plan.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation
import FirebaseDatabase

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
    var completed: Bool
    let ref: DatabaseReference?
    
    init(title: String,
         imageUrl: String,
         type: PlanType,
         completed: Bool) {
        self.title = title
        self.imageUrl = imageUrl
        self.type = type
        self.completed = completed
        self.ref = nil
    }
    
    init(snapShot: DataSnapshot) {
        let snapshotValue = snapShot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        imageUrl = snapshotValue["imageUrl"] as! String
        type = PlanType.init(rawValue: snapshotValue["type"] as! Int)!
        completed = snapshotValue["completed"] as! Bool
        ref = snapShot.ref
    }
    
    mutating func updateCompleted(completed: Bool) {
        self.completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "imageUrl": imageUrl,
            "type": type.rawValue,
            "completed": completed
        ]
    }
}
