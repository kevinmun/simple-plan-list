//
//  RootRouter.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
    weak var router: RootRouting? { get set }
    weak var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  mainBuilder: MainBuilder,
                  loggedOutBuilder: LoggedOutBuilder) {
        self.mainBuilder = mainBuilder
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOut()
    }
    
    // MARK : - RootRouting
    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.replaceModal(viewController: loggedOut.viewControllable)
    }
    
    func routeToMain() {
        // Detach logged out.
        if let loggedOut = self.loggedOut {
            detachChild(loggedOut)
            viewController.replaceModal(viewController: nil)
            self.loggedOut = nil
        }
        
        let main = mainBuilder.build(withListener: nil)
        self.main = main
        attachChild(main)
        viewController.replaceModal(viewController: main.viewControllable)
    }
    
    // MARK : - Private
    private var mainBuilder: MainBuilder
    private var loggedOutBuilder: LoggedOutBuilder
    
    private var loggedOut: ViewableRouting?
    private var main:ViewableRouting?
}
