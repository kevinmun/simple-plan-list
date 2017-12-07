//
//  RootViewController.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UITabBarController, RootPresentable, RootViewControllable {

    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: RootPresentableListener?
    
}
