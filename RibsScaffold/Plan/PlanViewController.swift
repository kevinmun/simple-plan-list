//
//  PlanViewController.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol PlanPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PlanViewController: UIViewController, PlanPresentable, PlanViewControllable {

    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: PlanPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Plan", image: nil, tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
}
