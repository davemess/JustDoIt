//
//  TodoItemViewControllerFactory.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Factory class for producing TodoItem view controllers.
class TodoItemViewControllerFactory {

    // MARK: - public
    
    func todoListViewController() -> TodoListViewController {
        let viewController = TodoListViewController()
        
        return viewController
    }
    
    func todoCreateViewController() -> TodoCreateViewController {
        let viewController = TodoCreateViewController()
        
        return viewController
    }
}
