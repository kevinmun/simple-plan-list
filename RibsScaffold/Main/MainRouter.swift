//
//  MainRouter.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol MainInteractable: Interactable {
    weak var router: MainRouting? { get set }
    weak var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {

    init(interactor: MainInteractable,
                  viewController: MainViewControllable,
                  planRouter: PlanRouting,
                  profileRouter: ProfileRouting) {
        self.planRouter = planRouter
        self.profileRouter = profileRouter
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachChild(self.planRouter)
        attachChild(self.profileRouter)
    }
    
    //MARK : - Private
    private var planRouter: PlanRouting
    private var profileRouter: ProfileRouting
}
