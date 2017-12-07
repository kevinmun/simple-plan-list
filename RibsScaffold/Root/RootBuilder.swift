//
//  RootBuilder.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        let planRouter = PlanBuilder(dependency: AppComponent()).build(withListener: nil)
        let searchRouter = SearchBuilder(dependency: AppComponent()).build(withListener: nil)
        
        let tabBarList = [planRouter.viewControllable, searchRouter.viewControllable] as? [UIViewController]
        viewController.viewControllers = tabBarList
        
        return RootRouter(interactor: interactor, viewController: viewController, planRouter: planRouter, searchRouter: searchRouter)
    }
}
