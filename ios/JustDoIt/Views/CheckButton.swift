//
//  CheckButton.swift
//  JustDoIt
//
//  Created by David Messing on 5/20/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Button for marking done/undone.
class CheckButton: UIButton {
    
    enum CheckState {
        case unchecked
        case checked
        
        func toggle() -> CheckState {
            switch self {
            case .unchecked:
                return .checked
            case .checked:
                return .unchecked
            }
        }
    }

    var checkState: CheckState = .unchecked {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    // MARK: - overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.image = checkState.image
    }
    
    // MARK: - public
    
    func toggle() {
        self.checkState = self.checkState.toggle()
    }
}

private extension CheckButton.CheckState {
    
    var image: UIImage {
        switch self {
        case .unchecked:
            return #imageLiteral(resourceName: "Button_unchecked")
        case .checked:
            return #imageLiteral(resourceName: "Button_checked")
        }
    }
}
