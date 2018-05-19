//
//  TodoListViewController.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Defines callbacks on TodoListViewController.
protocol TodoListViewControllerDelegate: class {
    func listViewControllerDidSelectAdd(_ viewController: TodoListViewController)
}

/// Displays a list of Todo Items.
class TodoListViewController: UIViewController {
    
    private struct Selector {
        static let add = #selector(addActionSelected)
    }
    
    weak var delegate: TodoListViewControllerDelegate?
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    // MARK: - view
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let barButtonItemFactory = BarButtonItemFactory()
        let addItem = barButtonItemFactory.addItem(self, action: Selector.add)
        
        navigationItem.rightBarButtonItem = addItem
        
        self.title = NSLocalizedString("Today", comment: "")
    }
    
    // MARK: - actions
    
    @objc private func addActionSelected() {
        self.delegate?.listViewControllerDidSelectAdd(self)
    }
}
