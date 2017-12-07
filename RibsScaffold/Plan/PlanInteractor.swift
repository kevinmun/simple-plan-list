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
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol PlanListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PlanInteractor: PresentableInteractor<PlanPresentable>, PlanInteractable, PlanPresentableListener {

    weak var router: PlanRouting?
    weak var listener: PlanListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: PlanPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
