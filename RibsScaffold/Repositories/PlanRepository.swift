//
//  PlanRepository.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseDatabase

protocol PlanRequestable: class {
    func getPlans() -> Observable<[Plan]>
    func savePlan(plan: Plan)
    func updatePlan(plan: Plan)
    func removePlan(plan: Plan)
}

final class PlanRepository: PlanRequestable {
    
    init() {
        plansRef = Database.database().reference(withPath: "plans")
    }
    
    func getPlans() -> Observable<[Plan]> {
        return plansRef.queryOrdered(byChild: "completed").rx_observeSingleEvent(of: .value).map { (snapShot) in
            var plans = [Plan]()
            for item in snapShot.children {
                let plan = Plan(snapShot: item as! DataSnapshot)
                plans.append(plan)
            }
            return plans
        }
    }
    
    func savePlan(plan: Plan) {
        plansRef.childByAutoId().setValue(plan.toAnyObject())
    }
    
    func updatePlan(plan: Plan) {
        plan.ref?.updateChildValues(plan.toAnyObject() as! [AnyHashable : Any])
    }
    
    func removePlan(plan: Plan) {
        plan.ref?.removeValue()
    }
    
    //MARK : - Private
    private let plansRef: DatabaseReference
    
}
