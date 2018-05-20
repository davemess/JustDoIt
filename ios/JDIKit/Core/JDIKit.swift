//
//  JDIKit.swift
//  JDIKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AFNAppKit
import CoreData

/// Entry point to the concrete classes of the JDIKit.
public class JDIKit {
    
    public enum JDIKitError: Error {
        case missingManagedObjectModel
        case missingManagedObjectContext
    }

    // MARK: - public properties
    
    public lazy var itemManager: ItemManager = {
        self.assertInitialized()
        
        let manager = ItemManager(managedObjectContextProvider: coreDataController)
        
        return manager
    }()
    
    // MARK: - private properties
    
    private lazy var coreDataController: CoreDataController = {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "JustDoItModel", withExtension: "momd")
        guard let modelUrl = url, let model = NSManagedObjectModel(contentsOf: modelUrl) else {
            let error = JDIKitError.missingManagedObjectModel
            fatalError()
        }
        let coreDataController = CoreDataController(managedObjectModel: model, persistentStoreName: "BrickLists")
        
        return coreDataController
    }()
    
    // MARK: - private funcs
    
    private func assertInitialized() {
        if !self.isInitialized {
            let errorMessage = "JDI must be initialized before use."
            assert(self.isInitialized, errorMessage)
        }
    }
    
    // MARK: - static
    
    static public let apiVersion = 1
    
    private var isInitialized: Bool = false
    
    // MARK: - lifecycle
    
    public static func initialize(_ completion: @escaping (Bool, Error?) -> Void) {
        sharedInstance.coreDataController.initialize { (success, error) in
            sharedInstance.isInitialized = success
            
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    static public var sharedInstance = JDIKit()
    private init(){}
}
