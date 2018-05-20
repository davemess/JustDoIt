//
//  ViewControllerFactoryProducer.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import JDIKit

/// Produces view controller factories.
struct ViewControllerFactoryProducer {
    
    // MARK: - public
    
    lazy var todoItemViewControllerFactory: TodoItemViewControllerFactory = {
        let itemManager =  JDIKit.sharedInstance.itemManager
        let factory = TodoItemViewControllerFactory(itemManager: itemManager)
        
        return factory
    }()
}
