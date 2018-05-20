//
//  ItemTableViewCell.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNUIUtilities
import JDIKit

/// Table view cell for displaying an Item.
class ItemTableViewCell: UITableViewCell, ReusableCell, NibProviding {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkButton: CheckButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private struct Constants {
        static let inProgressAlpha: CGFloat = 1.0
        static let doneAlpha: CGFloat = 0.4
    }
    
    // MARK: - overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        checkButton.checkState = .unchecked
        titleLabel.text = nil
        bgView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        bgView.layer.cornerRadius = 4.0
    }
    
    // MARK: - public
    
    func configure(with item: Item) {
        checkButton.setDone(item.isDone)
        titleLabel.text = item.content
        configureForDone(item.isDone)
    }
    
    // MARK: - private
    
    private func configureForDone(_ isDone: Bool) {
        if isDone {
            titleLabel.alpha = Constants.doneAlpha
            checkButton.alpha = Constants.doneAlpha
        } else {
            titleLabel.alpha = Constants.inProgressAlpha
            checkButton.alpha = Constants.inProgressAlpha
        }
    }
    
    // MARK: - actions
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.toggle()
    }
}

private extension CheckButton {

    func setDone(_ done: Bool) {
        checkState = done ? .checked : .unchecked
    }
}
