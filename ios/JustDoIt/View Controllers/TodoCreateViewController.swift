//
//  TodoCreateViewController.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNUIUtilities
import JDIKit

/// Defines callbacks on TodoCreateViewController.
protocol TodoCreateViewControllerDelegate: class {
    func createViewControllerDidDismiss(_ controller: TodoCreateViewController)
    func createViewController(_ controller: TodoCreateViewController, didFinishWith item: Item)
}

extension TodoCreateViewController: KeyboardAppearanceResponder, KeyboardObserverDelegate, ErrorAlertRenderer {

    var standardOffset: CGFloat {
        return 0.0
    }

    var bottomLayoutConstraint: NSLayoutConstraint {
        return _bottomLayoutConstraint
    }
}

/// Editor for creating a Todo Item.
class TodoCreateViewController: UIViewController {
    
    private struct Selector {
        static let cancel = #selector(cancelActionSelected)
        static let save =  #selector(saveActionSelected)
    }
    
    private enum State {
        case empty
        case editing
    }
    
    @IBOutlet private weak var _bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var editView: UIStackView!
    @IBOutlet weak var placeholderView: UIStackView!
    @IBOutlet weak var editTextView: UITextView!
    private var saveItem: UIBarButtonItem!
    
    override var shouldAutorotate: Bool { return false }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
    
    private let itemManager: ItemManager
    weak var delegate: TodoCreateViewControllerDelegate?
    
    private var state: State = .empty {
        didSet {
            reloadView(for: state)
        }
    }
    
    private var keyboardObserver = KeyboardObserver([.willShow, .willHide])
    
    // MARK: - lifecycle
    
    init(itemManager: ItemManager) {
        self.itemManager = itemManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.keyboardObserver.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        hideKeyboard()
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
    
    private func reloadView(for state: State) {
        switch state {
        case .empty:
            editView.isHidden = true
            placeholderView.isHidden = false
            hideKeyboard()
        case .editing:
            editView.isHidden = false
            placeholderView.isHidden = true
            editTextView.becomeFirstResponder()
        }
    }
    
    private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    private func confirmCancel() {
        let factory = ConfirmationDialogFactory()
        let alertController = factory.confirmationDialog(for: .discard) { (action) in
            self.delegate?.createViewControllerDidDismiss(self)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - data
    
    private func save() {
        let builder = itemManager.builder()
        builder.content = editTextView.text
        
        itemManager.create(builder, success: { (item) in
            self.delegate?.createViewController(self, didFinishWith: item)
        }) { (error) in
            self.present(error)
        }
    }
    
    // MARK: - actions
    
    @objc private func cancelActionSelected() {
        hideKeyboard()
        
        confirmCancel()
    }
    
    @objc private func saveActionSelected() {
        hideKeyboard()
        
        save()
    }
    
    @IBAction func beginEditingTapGestureRecognized(_ sender: UITapGestureRecognizer) {
        guard self.state == .empty else {
            return
        }
        
        self.state = .editing
        editTextView.becomeFirstResponder()
    }
    
    @IBAction func endEditingTapGestureRecognized(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
    private func formFieldEditingChanged(_ sender: Any) {
        reloadState()
    }
    
    private func reloadState() {
        self.state = editTextView.isEmpty ? .empty : .editing
    }
}

extension TodoCreateViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        formFieldEditingChanged(textView)
    }
}
