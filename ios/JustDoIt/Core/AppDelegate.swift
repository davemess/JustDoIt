//
//  AppDelegate.swift
//  JustDoIt
//
//  Created by David Messing on 3/31/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNAppKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Core components
    private let buildConfiguration: BuildConfiguration
    private let appFactory: AppFactory
    
    // View heirarchy
    var window: UIWindow?
    private let rootNavigationController = UINavigationController()
    private var rootCoordinator: AbstractCoordinator!
    
    // MARK: - lifecycle
    
    override init() {
        guard let buildConfiguration = BuildConfiguration(bundle: Bundle.main) else { fatalError("BuildConfiguration could not be assessed.") }
        
        self.buildConfiguration = buildConfiguration
        let appServices = AppServices(self.buildConfiguration)
        self.appFactory = AppFactory(appServices)
        
        super.init()
    }
    
    // MARK: - application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize services
        initializeLaunchServices(appFactory.launchServices, launchOptions: launchOptions)
        initializeWindow()
        initializeRootCoordinator()
        
        return true
    }

    // MARK: - private app initialization
    
    private func initializeLaunchServices(_ launchServices: [LaunchService], launchOptions: [UIApplicationLaunchOptionsKey : Any]?) {
        launchServices.forEach { (service) in
            service.initialize(launchOptions)
        }
    }
    
    private func initializeWindow() {
        let screenFrame = UIScreen.main.bounds
        window = UIWindow(frame: screenFrame)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    private func initializeRootCoordinator() {
        let rootCoordinator = appFactory.rootCoordinator(with: rootNavigationController)
        rootCoordinator.start(false)
        
        // must capture var
        self.rootCoordinator = rootCoordinator
    }
}

