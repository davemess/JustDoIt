//
//  AlertActionFactory.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

typealias AlertActionHandler = (UIAlertAction) -> Swift.Void

/// Factory for producing UIAlertActions.
struct AlertActionFactory {
    
    // MARK: - convienence
    
    func discardAlertAction(handler: @escaping AlertActionHandler) -> UIAlertAction {
        let action = self.alertAction(title: NSLocalizedString("Discard", comment: ""), style: .destructive, handler: handler)
        return action
    }
    
    func deleteAlertAction(handler: @escaping AlertActionHandler) -> UIAlertAction {
        let action = self.alertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: handler)
        return action
    }
    
    func cancelAlertAction(handler: @escaping AlertActionHandler) -> UIAlertAction {
        let action = self.alertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: handler)
        return action
    }
    
    // MARK: - public
    
    func alertAction(title: String, style: UIAlertActionStyle, handler: @escaping AlertActionHandler) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        return action
    }
}

