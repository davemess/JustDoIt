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
        
    }
}
