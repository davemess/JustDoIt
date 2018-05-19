//
//  AppFactory.swift
//  JustDoIt
//
//  Created by David Messing on 4/1/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Core factory for producing components necessary for app launch and run.
class AppFactory {
    
    // MARK: - properties
    
    var launchServices: [LaunchService] {
        let launchServices = appServices.services.filter { $0 is LaunchService }
        return launchServices as! [LaunchService]
    }
    
    // MARK: - private properties
    
    private lazy var viewControllerFactoryProducer: ViewControllerFactoryProducer = {
        let producer = ViewControllerFactoryProducer()
        return producer
    }()
    
    private let appServices: AppServices
    
    // MARK: - lifecyle
    
    init(_ appServices: AppServices) {
        self.appServices = appServices
    }
    
    // MARK: - public
    
    func applicationWindow(_ frame: CGRect) -> UIWindow {
        let window = UIWindow(frame: frame)
        return window
    }
    
    func rootCoordinator(with navigationController: UINavigationController) -> AbstractCoordinator {
        let todoItemViewControllerFactory = viewControllerFactoryProducer.todoItemViewControllerFactory
        let rootCoordinator = RootAppCoordinator(navigationController, todoItemViewControllerFactory: todoItemViewControllerFactory)
        
        return rootCoordinator
    }
    
}
