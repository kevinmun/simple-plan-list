//
//  SearchRouter.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

protocol SearchInteractable: Interactable {
    weak var router: SearchRouting? { get set }
    weak var listener: SearchListener? { get set }
}

protocol SearchViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchInteractable, viewController: SearchViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
