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
    var userRepository: UserRequestable { get }
}

final class RootComponent: Component<RootDependency>, LoggedOutDependency, MainDependency {
    var userRepository: UserRequestable {
        return dependency.userRepository
    }
    
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
        
        let mainBuilder = MainBuilder(dependency: component)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        
        return RootRouter(interactor: interactor, viewController: viewController, mainBuilder: mainBuilder, loggedOutBuilder: loggedOutBuilder)
    }
}
