//
//  ConfirmationDialogFactory.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNUIUtilities

/// Factory for producing confirmation dialogs.
class ConfirmationDialogFactory {
    
    enum ConfirmationDialogType {
        case discard
    }
    
    private struct ConfirmationDialogConfiguration {
        let title: String
        let message: String
        let confirmationAction: UIAlertAction
    }
    
    private let factory = AlertActionFactory()
    
    // MARK: - public
    
    func confirmationDialog(for type: ConfirmationDialogType, with dismissAlertAction: @escaping AlertActionHandler) -> UIAlertController {
        let configuration: ConfirmationDialogConfiguration = self.configuration(for: type, with: dismissAlertAction)
        
        let alertController = UIAlertController(title: configuration.title, message: configuration.message, preferredStyle: .actionSheet)
        let cancelAction = factory.cancelAlertAction { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(configuration.confirmationAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    // MARK: - private
    
    private func configuration(for type: ConfirmationDialogType, with dismissAlertAction: @escaping AlertActionHandler) -> ConfirmationDialogConfiguration {
        let title: String
        let message: String
        let confirmationAction: UIAlertAction
        
        switch type {
        case .discard:
            title = NSLocalizedString("Are you sure you want to exit?", comment: "")
            message = NSLocalizedString("You will lose any progress. This action cannot be undone.", comment: "")
            confirmationAction = factory.discardAlertAction(handler: dismissAlertAction)
        }
        
        return ConfirmationDialogConfiguration(title: title, message: message, confirmationAction: confirmationAction)
    }
}
