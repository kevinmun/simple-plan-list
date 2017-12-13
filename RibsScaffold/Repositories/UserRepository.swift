//
//  UserRepository.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

protocol UserRequestable: class {
    var user: User? { get }
    func login(username: String, password: String) -> Observable<Bool>
}

final class UserRepository: UserRequestable {
    
    init() { }
    
    var user: User? {
        return Auth.auth().currentUser
    }
    
    func login(username: String, password: String) -> Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
                if let _ = error {
                    observer.onNext(false)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
}
