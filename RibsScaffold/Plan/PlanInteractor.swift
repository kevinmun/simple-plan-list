//
//  PlanInteractor.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift

protocol PlanRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PlanPresentable: Presentable {
    weak var listener: PlanPresentableListener? { get set }
}

protocol PlanMainPresentable: PlanPresentable {
    func setLoading(active: Bool)
    func reloadData()
    func updateSource(plans: [Plan])
}

protocol PlanListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PlanInteractor: PresentableInteractor<PlanMainPresentable>, PlanInteractable, PlanPresentableListener {

    weak var router: PlanRouting?
    weak var listener: PlanListener?
    weak var planRepository: PlanRequestable?

    init(presenter: PlanMainPresentable, planRepository: PlanRequestable) {
        self.planRepository = planRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        getPlans()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // Mark : - PlanPresentableListener
    func refreshPlan() {
        getPlans()
    }
    
    func addPlan(title: String) {
        let plan = Plan(title: title, imageUrl: title, type: PlanType.randomPlanType(), completed: false)
        planRepository?.savePlan(plan: plan)
        getPlans()
    }
    
    func removePlan(plan: Plan) {
        planRepository?.removePlan(plan: plan)
    }
    
    func updatePlan(plan: Plan) {
        planRepository?.updatePlan(plan: plan)
        getPlans()
    }
    
    // Mark : - Private
    private func getPlans() {
        planRepository?.getPlans()
            .subscribe(onNext: { plans in
                self.presenter.updateSource(plans: plans)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
