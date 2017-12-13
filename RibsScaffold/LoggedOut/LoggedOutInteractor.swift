//
//  LoggedOutInteractor.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 08/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    weak var listener: LoggedOutPresentableListener? { get set }
    func didLoginError()
}

protocol LoggedOutListener: class {
    func didLogin()
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    weak var userRequestable: UserRequestable?

    init(presenter: LoggedOutPresentable, userRequestable: UserRequestable) {
        self.userRequestable = userRequestable
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func login(withUsername username: String?, password: String?) {
        if let username = username, let password = password {
            userRequestable?.login(username: username, password: password)
                .subscribe(onNext: { [weak self] success in
                    if success {
                        self?.listener?.didLogin()
                    } else {
                        self?.presenter.didLoginError()
                    }
                })
                .disposeOnDeactivate(interactor: self)
        }
        
    }
    
    func createUser(email: String?, password: String?) {
        if let email = email, let password = password {
            userRequestable?.createUser(email: email, password: password)
                .subscribe(onNext: { [weak self] success in
                    if success {
                        self?.listener?.didLogin()
                    } else {
                        self?.presenter.didLoginError()
                    }
                })
                .disposeOnDeactivate(interactor: self)
        }
    }
}
