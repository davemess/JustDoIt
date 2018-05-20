//
//  JDIKitError+ErrorAlert.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import JDIKit
import AFNUIUtilities

extension JDIKitError: ErrorAlertConvertible {
    
    public var errorAlert: ErrorAlert {
        return ErrorAlert(title: NSLocalizedString("Error", comment: ""),
                          message: self.localizedDescription,
                          actions: okAction)
    }
    
    private var okAction: UIAlertAction {
        let title = NSLocalizedString("Ok", comment: "")
        let okAction = UIAlertAction(title: title, style: .default, handler:nil)
        
        return okAction
    }
}
