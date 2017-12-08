//
//  PlanBuilder.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol PlanDependency: Dependency {
    var planRepository: PlanRequestable { get }
    
}

final class PlanComponent: Component<PlanDependency> {
    var planRepository: PlanRequestable {
        return dependency.planRepository
    }
}

// MARK: - Builder

protocol PlanBuildable: Buildable {
    func build(withListener listener: PlanListener?) -> PlanRouting
}

final class PlanBuilder: Builder<PlanDependency>, PlanBuildable {

    override init(dependency: PlanDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PlanListener?) -> PlanRouting {
        let component = PlanComponent(dependency: dependency)
        let viewController = PlanViewController()
        let interactor = PlanInteractor(presenter: viewController, planRepository: component.planRepository)
        interactor.listener = listener
        return PlanRouter(interactor: interactor, viewController: viewController)
    }
}
