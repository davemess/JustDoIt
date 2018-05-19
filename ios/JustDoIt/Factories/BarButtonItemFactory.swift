//
//  BarButtonItemFactory.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Factory for producing bar button items.
struct BarButtonItemFactory {
    
    func saveItem(_ target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = self.textItem(NSLocalizedString("Save", comment: ""), target: target, action: action)
        return item
    }
    
    func cancelItem(_ target: Any?, action: Selector?) -> UIBarButtonItem {
        let item: UIBarButtonSystemItem = .cancel
        return self.systemItem(barButtonSystemItem: item, target: target, action: action)
    }
    
    func addItem(_ target: Any?, action: Selector?) -> UIBarButtonItem {
        let item: UIBarButtonSystemItem = .add
        return self.systemItem(barButtonSystemItem: item, target: target, action: action)
    }
    
    func flexItem() -> UIBarButtonItem {
        let item: UIBarButtonSystemItem = .flexibleSpace
        return self.systemItem(barButtonSystemItem: item, target: nil, action: nil)
    }
    
    // MARK: - private
    
    private func imageItem(_ image: UIImage, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        return item
    }
    
    private func textItem(_ title: String, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        return item
    }
    
    private func systemItem(barButtonSystemItem systemItem: UIBarButtonSystemItem, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: systemItem, target: target, action: action)
        return item
    }
}
