//
//  LoggedOutViewController.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 08/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: class {
    func login(withUsername: String?, password: String?)
    func createUser(email: String?, password: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: LoggedOutPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let loginFields = buildLoginFields()
        buildLoginButton(withUsernameField: loginFields.usernameField, passwordField: loginFields.passwordField)
    }
    
    func didLoginError() {
        view.activityIndicatorView.stopAnimating()
        let alert = UIAlertController(title: "Login Error", message: "Login Error", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK : - Private
    private func buildLoginFields() -> (usernameField: UITextField, passwordField: UITextField) {
        let usernameField = UITextField()
        usernameField.borderStyle = UITextBorderStyle.line
        view.addSubview(usernameField)
        usernameField.placeholder = "Username"
        usernameField.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(40)
        }
        
        let passwordField = UITextField()
        passwordField.borderStyle = UITextBorderStyle.line
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        passwordField.placeholder = "Password"
        passwordField.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(usernameField.snp.bottom).offset(20)
            maker.left.right.height.equalTo(usernameField)
        }
        
        return (usernameField, passwordField)
    }
    
    private func buildLoginButton(withUsernameField usernameField: UITextField, passwordField: UITextField) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(passwordField.snp.bottom).offset(20)
            maker.left.right.height.equalTo(usernameField)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.gray
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.activityIndicatorView.startAnimating()
                self?.listener?.login(withUsername: usernameField.text, password: passwordField.text)
            })
            .disposed(by: disposeBag)
        
        let registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(loginButton.snp.bottom).offset(20)
            maker.left.right.height.equalTo(loginButton)
        }
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.backgroundColor = UIColor.gray
        registerButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                let alert = UIAlertController(title: "Register",
                                              message: "Register",
                                              preferredStyle: .alert)

                let saveAction = UIAlertAction(title: "Save",
                                               style: .default) {[unowned self, weak alert = alert] action in
                    let emailFieldText = alert?.textFields![0].text
                    let passwordFieldText = alert?.textFields![1].text
                    self.listener?.createUser(email: emailFieldText, password: passwordFieldText)
                }

                let cancelAction = UIAlertAction(title: "Cancel",
                                                 style: .default)

                alert.addTextField { textEmail in
                    textEmail.placeholder = "Enter your email"
                }

                alert.addTextField { textPassword in
                    textPassword.isSecureTextEntry = true
                    textPassword.placeholder = "Enter your password"
                }

                alert.addAction(saveAction)
                alert.addAction(cancelAction)

                self.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}
