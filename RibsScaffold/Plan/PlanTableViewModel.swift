//
//  PlanTableViewModel.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 08/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation
import RIBs

class PlanTableCellViewModel: PlanPresentable {
    var listener: PlanPresentableListener?
    private var plan: Plan?
    var planTitle: String? {
        get {
            return plan?.title
        }
    }
    var planImageUrl: String? {
        get {
            return plan?.imageUrl
        }
    }
    var planType: PlanType? {
        get {
            return plan?.type
        }
    }
    
    var completed: Bool {
        get {
            if let plan = plan {
                return plan.completed
            }
            return false
        }
    }
    
    func updateCompleted(completed: Bool) {
        if var plan = plan {
            plan.updateCompleted(completed: completed)
            listener?.updatePlan(plan: plan)
        }
    }
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    
}

class PlanTableViewModel: Presenter<PlanViewController>, PlanMainPresentable {
    var listener: PlanPresentableListener?
    private(set) var dataSource: [PlanTableCellViewModel]?
    
    func addRandomPlan() {
        listener?.addRandomPlan()
    }
    
    func refreshPlan() {
        listener?.refreshPlan()
    }
    
    func setLoading(active: Bool) {
        viewController.setLoading(active: active)
    }
    
    func updateSource(plans: [Plan]) {
        dataSource = plans.map { (plan) -> PlanTableCellViewModel in
            let vm = PlanTableCellViewModel(plan: plan)
            vm.listener = listener
            return vm
        }
        reloadData()
    }
    
    func reloadData() {
        viewController.reloadData()
    }
}


