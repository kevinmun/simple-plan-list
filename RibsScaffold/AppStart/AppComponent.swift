//
//  AppComponent.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    var planRepository: PlanRequestable {
        return shared { PlanRepository() }
    }
    
    var userRepository: UserRequestable {
        return shared { UserRepository() }
    }
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}

