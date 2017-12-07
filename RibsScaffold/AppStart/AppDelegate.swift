//
//  AppDelegate.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//
import RIBs
import UIKit

/// Game app delegate.
@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The window.
    public var window: UIWindow?
    
    /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
    ///
    /// - parameter application: Your singleton app object.
    /// - parameter launchOptions: A dictionary indicating the reason the app was launched (if any). The contents of
    ///   this dictionary may be empty in situations where the user launched the app directly. For information about
    ///   the possible keys in this dictionary and how to handle them, see Launch Options Keys.
    /// - returns: false if the app cannot handle the URL resource or continue a user activity, otherwise return true.
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
        
        return true
    }
    
    // MARK: - Private
    
    private var launchRouter: LaunchRouting?
}

