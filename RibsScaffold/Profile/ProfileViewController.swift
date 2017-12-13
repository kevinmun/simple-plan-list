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
import SnapKit

protocol ProfilePresentableListener: class {
    var username: String? { get }
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
        view.backgroundColor = UIColor.white
        buildUserLabel()
        if let username = listener?.username {
            updateUserName(username: username)
        }
    }
    
    func updateUserName(username: String) {
        userLabel?.text = username
    }
    
    // MARK : - Private
    private func buildUserLabel() {
        userLabel = UILabel()
        view.addSubview(userLabel!)
        userLabel!.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(15)
            maker.height.equalTo(40)
            maker.left.equalTo(self.view).offset(15)
            maker.right.equalTo(self.view).offset(-15)
        }
        userLabel!.textColor = UIColor.black
    }
    
    private var userLabel: UILabel?
}
