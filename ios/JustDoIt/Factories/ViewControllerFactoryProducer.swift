//
//  ViewControllerFactoryProducer.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Produces view controller factories.
struct ViewControllerFactoryProducer {
    
    // MARK: - public
    
    lazy var todoItemViewControllerFactory: TodoItemViewControllerFactory = {
        let factory = TodoItemViewControllerFactory()
        
        return factory
    }()
}
