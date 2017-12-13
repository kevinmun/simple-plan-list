//
//  ProfileInteractor.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift

protocol ProfileRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ProfilePresentable: Presentable {
    weak var listener: ProfilePresentableListener? { get set }
    
    func updateUserName(username: String)
}

protocol ProfileListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ProfileInteractor: PresentableInteractor<ProfilePresentable>, ProfileInteractable, ProfilePresentableListener {

    weak var router: ProfileRouting?
    weak var listener: ProfileListener?
    weak var userRepository: UserRequestable?
    
    var username: String? {
        return userRepository?.user?.email
    }
    
    init(presenter: ProfilePresentable, userRepository: UserRequestable) {
        self.userRepository = userRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
