//
//  PlanRepository.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import Foundation
import RxSwift

protocol PlanRequestable: class {
    func getPlans() -> Observable<[Plan]>
}

final class MockPlanRepository: PlanRequestable {
    //TODO: this should connect to a service which would return an observable stream
    func getPlans() -> Observable<[Plan]> {
         let planObservable = Observable<[Plan]>.create { observer in
            var plans = [Plan]()
            for index in 0..<10 {
                let plan = Plan(title: "Plan \(index)", imageUrl: "imageUrl \(index)")
                plans.append(plan)
            }
            observer.onNext(plans)
            observer.onCompleted()
            return Disposables.create()
        }
        
        return planObservable
            .delay(3.0, scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
    }
}
