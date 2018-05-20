//
//  ItemManager.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import CoreData
import AFNAppKit

/// Defines a central repository and interactor for Items.
public class ItemManager {
    
    /// Builder pattern object for creating Items.
    public class Builder {
        
        public var content: String?
        public var isDone: Bool = false
        
        private let managedObjectContext: NSManagedObjectContext
        
        // MARK: - lifecycle
        
        init(managedObjectContext: NSManagedObjectContext) {
            self.managedObjectContext = managedObjectContext
        }
        
        // MARK: - public
        
        func build(success: @escaping (Item) -> Void, failure: @escaping (Error) -> Void) {
            guard let content = content, content.count > 0 else {
                let reason = NSLocalizedString("Content is required.", comment: "")
                let error = JDIKitError.validationFailure(reason: reason)
                failure(error)
                return
            }
            
            let item = Item(context: managedObjectContext)
            item.content = self.content
            success(item)
        }
    }
    
    private let managedObjectContextProvider: ManagedObjectContextProvider
    
    // MARK: - lifecycle
    
    init(managedObjectContextProvider: ManagedObjectContextProvider) {
        self.managedObjectContextProvider = managedObjectContextProvider
    }
    
    // MARK: - pubulic
    
    public func builder() -> Builder {
        let context = managedObjectContextProvider.viewContext
        let builder = Builder(managedObjectContext: context)
        return builder
    }
    
    public func create(_ builder: Builder, success: @escaping (Item) -> Void, failure: @escaping (Error) -> Void) {
        builder.build(success: { (item) in
            self.save(item, success: success, failure: failure)
        }, failure: failure)
    }
    
    public func save(_ item: Item, success: @escaping (Item) -> Void, failure: @escaping (Error) -> Void) {
        guard let context = item.managedObjectContext else {
            failure(JDIKitError.missingManagedObjectContext)
            return
        }
        
        do {
            try context.save()
            success(item)
        } catch {
            failure(error)
        }
    }

    public func listDataSource(queryRef: AFNPageRef<Item>) -> ItemListDataSource {
        let fetchRequst: NSFetchRequest<Item> = queryRef.toFetchRequest()
        let context = managedObjectContextProvider.viewContext
        let dataSource = ItemListDataSource(fetchRequest: fetchRequst, managedObjectContext: context)
        return dataSource
    }
}
