//
//  KeyboardAppearanceResponder.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNUIUtilities

/// Describes properties necessary for responding to a keyboard event.
protocol KeyboardAppearanceResponder {
    var standardOffset: CGFloat { get }
    var bottomLayoutConstraint: NSLayoutConstraint { get }
}

extension KeyboardObserverDelegate where Self: UIViewController & KeyboardAppearanceResponder {
    
    func keyboardObserverDidObserve(_ observer: KeyboardObserver, event: KeyboardEventInfo) {
        let type = event.type
        let height = event.keyboardFrame?.size.height ?? 0
        let duration = event.animationDuration ?? 0.0
        var offset: CGFloat = self.bottomLayoutConstraint.constant
        
        switch type {
        case .willShow:
            offset = height
        case .willHide:
            offset = standardOffset
        default:
            break
        }
        
        UIView.animate(withDuration: duration) {
            self.bottomLayoutConstraint.constant = offset
            self.view.layoutIfNeeded()
        }
    }
}
