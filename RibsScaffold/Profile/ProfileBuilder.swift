//
//  ProfileBuilder.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol ProfileDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ProfileComponent: Component<ProfileDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ProfileBuildable: Buildable {
    func build(withListener listener: ProfileListener?) -> ProfileRouting
}

final class ProfileBuilder: Builder<ProfileDependency>, ProfileBuildable {

    override init(dependency: ProfileDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ProfileListener?) -> ProfileRouting {
        let component = ProfileComponent(dependency: dependency)
        let viewController = ProfileViewController()
        let interactor = ProfileInteractor(presenter: viewController)
        interactor.listener = listener
        return ProfileRouter(interactor: interactor, viewController: viewController)
    }
}
