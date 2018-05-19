//
//  TodoCreateViewController.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNUIUtilities

/// Defines callbacks on TodoCreateViewController.
protocol TodoCreateViewControllerDelegate: class {
    func createViewControllerDidDismiss(_ controller: TodoCreateViewController)
    func createViewControllerDidFinish(_ controller: TodoCreateViewController)
}

//extension TodoCreateViewController: KeyboardAppearanceResponder, KeyboardObserverDelegate {
//
//    var standardOffset: CGFloat {
//        return 0.0
//    }
//
//    var bottomLayoutConstraint: NSLayoutConstraint {
//        return _bottomLayoutConstraint
//    }
//}

/// Editor for creating a Todo Item.
class TodoCreateViewController: UIViewController {
    
    private struct Selector {
        static let cancel = #selector(cancelActionSelected)
        static let save =  #selector(saveActionSelected)
    }
    
    @IBOutlet private weak var _bottomLayoutConstraint: NSLayoutConstraint!
    private var saveItem: UIBarButtonItem!
    
    override var shouldAutorotate: Bool { return false }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
    
    weak var delegate: TodoCreateViewControllerDelegate?
    
    private var keyboardObserver = KeyboardObserver([.willShow, .willHide])
    private var firstLoad: Bool = true
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureFirstLoad()
    }
    
    // MARK: - view
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let barButtonItemFactory = BarButtonItemFactory()
        let cancelItem = barButtonItemFactory.cancelItem(self, action: Selector.cancel)
        saveItem = barButtonItemFactory.saveItem(self, action: Selector.save)
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = saveItem
        
        self.title = NSLocalizedString("Add an Item", comment: "")
    }
    
    private func configureFirstLoad() {
        if firstLoad == true {
            firstLoad = false
        }
    }
    
    private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - actions
    
    @objc private func cancelActionSelected() {
        hideKeyboard()
        
        self.delegate?.createViewControllerDidDismiss(self)
    }
    
    @objc private func saveActionSelected() {
        hideKeyboard()
        
        self.delegate?.createViewControllerDidFinish(self)
    }
}
