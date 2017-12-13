//
//  ProfileRouter.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol ProfileInteractable: Interactable {
    weak var router: ProfileRouting? { get set }
    weak var listener: ProfileListener? { get set }
}

protocol ProfileViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ProfileRouter: ViewableRouter<ProfileInteractable, ProfileViewControllable>, ProfileRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ProfileInteractable, viewController: ProfileViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
