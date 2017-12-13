//
//  Firebase+RxSwift.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RxSwift

extension DatabaseQuery {
    
    func rx_observeSingleEvent(of event: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create({ (observer) -> Disposable in
            self.observeSingleEvent(of: event, with: { (snapshot) in
                observer.onNext(snapshot)
                observer.onCompleted()
            }, withCancel: { (error) in
                observer.onError(error)
            })
            return Disposables.create()
        })
    }
    
    func rx_observeEvent(event: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create({ (observer) -> Disposable in
            let handle = self.observe(event, with: { (snapshot) in
                observer.onNext(snapshot)
            }, withCancel: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
                self.removeObserver(withHandle: handle)
            }
        })
    }
}
