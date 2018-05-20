//
//  RootAppCoordinator.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import JDIKit

/// Navigation coordinator for root application context.
class RootAppCoordinator: AbstractCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators = [AbstractCoordinator]()
    
    private let todoItemViewControllerFactory: TodoItemViewControllerFactory
    private var rootCoordinator: AbstractCoordinator?
    
    // MARK: - lifecycle
    
    init(_ navigationController: UINavigationController, todoItemViewControllerFactory: TodoItemViewControllerFactory) {
        self.navigationController = navigationController
        self.todoItemViewControllerFactory = todoItemViewControllerFactory
    }
    
    // MARK: - AbstractCoordinator
    
    func start(_ animated: Bool) {
        let viewController = todoItemViewControllerFactory.todoListViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension RootAppCoordinator: TodoListViewControllerDelegate {
    
    func listViewControllerDidSelectAdd(_ viewController: TodoListViewController) {
        let viewController = todoItemViewControllerFactory.todoCreateViewController()
        viewController.delegate = self
        
        let navController = UINavigationController(rootViewController: viewController)
        navigationController.present(navController, animated: true, completion: nil)
    }
}

extension RootAppCoordinator: TodoCreateViewControllerDelegate {
    
    func createViewControllerDidDismiss(_ controller: TodoCreateViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func createViewController(_ controller: TodoCreateViewController, didFinishWith item: Item) {
        controller.dismiss(animated: true, completion: nil)
    }
}
