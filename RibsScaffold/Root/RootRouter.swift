//
//  RootRouter.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable {
    weak var router: RootRouting? { get set }
    weak var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  planRouter: PlanRouting,
                  searchRouter: SearchRouting) {
        self.planRouter = planRouter
        self.searchRouter = searchRouter
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    
    // MARK : - Private
    private var planRouter: PlanRouting
    private var searchRouter: SearchRouting
}
