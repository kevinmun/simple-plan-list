//
//  ProfileViewController.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 13/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol ProfilePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ProfileViewController: UIViewController, ProfilePresentable, ProfileViewControllable {

    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: ProfilePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
}
