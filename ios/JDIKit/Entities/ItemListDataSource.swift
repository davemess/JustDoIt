//
//  ItemListDataSource.swift
//  JDIKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import CoreData

/// Defines callbacks on a ItemListDataSource.
public protocol ItemListDataSourceDelegate: class {
    func itemListDataSourceDidReload(_ dataSource: ItemListDataSource)
    func itemListDataSource(_ dataSource: ItemListDataSource, didInsert item: Item, at indexPath: IndexPath)
    func itemListDataSource(_ dataSource: ItemListDataSource, didDelete item: Item, at indexPath: IndexPath)
    func itemListDataSource(_ dataSource: ItemListDataSource, didUpdate item: Item, at indexPath: IndexPath)
    func itemListDataSource(_ dataSource: ItemListDataSource, didMove item: Item, at indexPath: IndexPath, to newIndexPath: IndexPath)
}

/// Data source for a ItemListViewController.
public class ItemListDataSource: NSObject {
    
    public typealias T = Item
    
    public weak var delegate: ItemListDataSourceDelegate?
    
    private let fetchedResultsController: NSFetchedResultsController<T>
    
    // MARK: - lifecycle
    
    init(fetchRequest: NSFetchRequest<Item>, managedObjectContext: NSManagedObjectContext) {
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        self.fetchedResultsController.delegate = self
    }
    
    // MARK: - public
    
    public func reloadData(success: @escaping ([Item]) -> Void, failure: @escaping (Error) -> Void) {
        do {
            try fetchedResultsController.performFetch()
            let result: [Item] = fetchedResultsController.fetchedObjects ?? []
            success(result)
        } catch {
            failure(error)
        }
    }
    
    // MARK: - SectionedDataSource
    
    public func numberOfSections() -> Int {
        let sections = fetchedResultsController.sections
        return sections?.count ?? 0
    }
    
    public func numberOfItems(in section: Int) -> Int {
        let items = fetchedResultsController.sections?[section]
        return items?.numberOfObjects ?? 0
    }
    
    public func item(at indexPath: IndexPath) -> T {
        let item = fetchedResultsController.object(at: indexPath)
        return item
    }
    
    public func indexPath(of item: T) -> IndexPath? {
        let indexPath = fetchedResultsController.indexPath(forObject: item)
        return indexPath
    }
}

extension ItemListDataSource: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.itemListDataSourceDidReload(self)
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let item = anObject as? Item, let indexPath = indexPath else { return }
        
        switch type {
        case .insert:
            delegate?.itemListDataSource(self, didInsert: item, at: indexPath)
        case .delete:
            delegate?.itemListDataSource(self, didDelete: item, at: indexPath)
        case .update:
            delegate?.itemListDataSource(self, didUpdate: item, at: indexPath)
        case .move:
            guard let newIndexPath = newIndexPath else { return }
            delegate?.itemListDataSource(self, didMove: item, at: indexPath, to: newIndexPath)
        }
    }
    
}
