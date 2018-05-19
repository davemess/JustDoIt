//
//  UITextView+Extensions.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

extension UITextView {
    
    var isEmpty: Bool {
        return (self.text == nil) || (self.text.count == 0)
    }
}
