//
//  MainBuilder.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol MainDependency: Dependency {
    var planRepository: PlanRequestable { get }
    var userRepository: UserRequestable { get }
}

final class MainComponent: Component<MainDependency>, ProfileDependency, PlanDependency {
    var planRepository: PlanRequestable {
        return dependency.planRepository
    }
    
    var userRepository: UserRequestable {
        return dependency.userRepository
    }
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener?) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener?) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        
        let planRouter = PlanBuilder(dependency: component).build(withListener: nil)
        let profileRouter = ProfileBuilder(dependency: component).build(withListener: nil)
        let planNav = UINavigationController(root: planRouter.viewControllable)
        let tabBarList = [planNav, profileRouter.viewControllable] as? [UIViewController]
        viewController.viewControllers = tabBarList
        
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        return MainRouter(interactor: interactor, viewController: viewController, planRouter: planRouter, profileRouter: profileRouter)
    }
}
