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
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    
}

class PlanTableViewModel: Presenter<PlanViewController>, PlanMainPresentable {
    var listener: PlanPresentableListener?
    private(set) var dataSource: [PlanTableCellViewModel]?
    
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

