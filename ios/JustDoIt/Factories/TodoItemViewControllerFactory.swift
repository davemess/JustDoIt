//
//  TodoItemViewControllerFactory.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import JDIKit

/// Factory class for producing TodoItem view controllers.
class TodoItemViewControllerFactory {
    
    private let itemManager: ItemManager
    
    // MARK: - lifecycle
    
    init(itemManager: ItemManager) {
        self.itemManager = itemManager
    }

    // MARK: - public
    
    func todoListViewController() -> TodoListViewController {
        let viewController = TodoListViewController(itemManager: itemManager)
        
        return viewController
    }
    
    func todoCreateViewController() -> TodoCreateViewController {
        let viewController = TodoCreateViewController(itemManager: itemManager)
        
        return viewController
    }
}
