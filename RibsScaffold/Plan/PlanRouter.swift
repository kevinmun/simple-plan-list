//
//  PlanRouter.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol PlanInteractable: Interactable {
    weak var router: PlanRouting? { get set }
    weak var listener: PlanListener? { get set }
}

protocol PlanViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PlanRouter: ViewableRouter<PlanInteractable, PlanViewControllable>, PlanRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PlanInteractable, viewController: PlanViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
