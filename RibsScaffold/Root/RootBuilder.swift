//
//  RootBuilder.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    var planRepository: PlanRequestable { get }
}

final class RootComponent: Component<RootDependency>, SearchDependency, PlanDependency {
    var planRepository: PlanRequestable {
        return dependency.planRepository
    }
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
        
        let planRouter = PlanBuilder(dependency: component).build(withListener: nil)
        let searchRouter = SearchBuilder(dependency: component).build(withListener: nil)
        
        let tabBarList = [planRouter.viewControllable, searchRouter.viewControllable] as? [UIViewController]
        viewController.viewControllers = tabBarList
        
        return RootRouter(interactor: interactor, viewController: viewController, planRouter: planRouter, searchRouter: searchRouter)
    }
}
