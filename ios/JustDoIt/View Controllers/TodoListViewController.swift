//
//  TodoListViewController.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNAppKit
import AFNUIUtilities
import JDIKit

/// Defines callbacks on TodoListViewController.
protocol TodoListViewControllerDelegate: class {
    func listViewControllerDidSelectAdd(_ viewController: TodoListViewController)
}

extension TodoListViewController: ErrorAlertRenderer {}

/// Displays a list of Todo Items.
class TodoListViewController: UIViewController {
    
    private struct Selector {
        static let add = #selector(addActionSelected)
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let itemManager: ItemManager
    private let dataSource: ItemListDataSource
    
    weak var delegate: TodoListViewControllerDelegate?
    
    // MARK: - lifecycle
    
    init(itemManager: ItemManager) {
        let query = AFNQuery(constraints: [
            .sort(key: "isDone", order: .ascending),
            ])
        let queryRef: AFNPageRef<Item> = AFNPageRef(query: query)
        
        self.itemManager = itemManager
        self.dataSource = itemManager.listDataSource(queryRef: queryRef)
        
        super.init(nibName: nil, bundle: nil)
        
        self.dataSource.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureViewController()
        
        reloadData()
    }
    
    // MARK: - view
    
    private func configureView() {
        tableView.registerReusableCell(ItemTableViewCell.self)
        tableView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let barButtonItemFactory = BarButtonItemFactory()
        let addItem = barButtonItemFactory.addItem(self, action: Selector.add)
        
        navigationItem.rightBarButtonItem = addItem
        
        self.title = NSLocalizedString("Today", comment: "")
    }
    
    // MARK: - data
    
    private func reloadData() {
        dataSource.reloadData(success: { (result) in
            self.handleLoad(result)
        }) { (error) in
            self.handleError(error)
        }
    }
    
    private func handleLoad(_ results: [Item]) {
        tableView.reloadData()
    }
    
    private func handleError(_ error: Error) {
        self.present(error)
    }
    
    // MARK: - actions
    
    @objc private func addActionSelected() {
        self.delegate?.listViewControllerDidSelectAdd(self)
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = dataSource.item(at: indexPath)
        cell.configure(with: item)
        
        return cell
    }
}

extension TodoListViewController: ItemListDataSourceDelegate {
    
    func itemListDataSourceDidReload(_ dataSource: ItemListDataSource) {
        tableView.reloadData()
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didInsert item: Item, at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didDelete item: Item, at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didUpdate item: Item, at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didMove item: Item, at indexPath: IndexPath, to newIndexPath: IndexPath) {
        tableView.moveRow(at: indexPath, to: newIndexPath)
        tableView.reloadRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
    }
}
