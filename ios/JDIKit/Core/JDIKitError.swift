//
//  JDIKitError.swift
//  JDIKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Describes errors that may be encountered in use of JDIKit.
public enum JDIKitError: Error, LocalizedError {
    case missingManagedObjectModel
    case missingManagedObjectContext
    
    case validationFailure(reason: String)
    
    public var localizedDescription: String {
        switch self {
        case .missingManagedObjectModel:
            return NSLocalizedString("Core Data could not be initialized dure to a missing model. Please contact the developer.", comment: "")
        case .missingManagedObjectContext:
            return NSLocalizedString("Core Data could not be initialized dure to a missing context. Please contact the developer.", comment: "")
        case .validationFailure(let reason):
            return String.localizedStringWithFormat(NSLocalizedString("Validation failed due to: %@", comment: ""), reason)
        }
    }
}
