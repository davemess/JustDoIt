//
//  WeatherDisplayView.swift
//  JustDoIt
//
//  Created by David Messing on 5/20/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Defines callbacks on WeatherDisplayView.
protocol WeatherDisplayViewDelegate: class {
    func weatherDisplayViewDidTapSetup(_ view: WeatherDisplayView)
}

/// Custom view for displaying weather at the user's location.
class WeatherDisplayView: UIView {

    enum State {
        case needsSetup
        case permitted(message: String)
        case error(message: String)
    }

    @IBOutlet private weak var setupView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var displayView: UIView!
    @IBOutlet private weak var displayLabel: UILabel!
    
    var state: State = .needsSetup {
        didSet {
            reloadView(for: state)
        }
    }
    
    weak var delegate: WeatherDisplayViewDelegate?
    
    // MARK: - actions
    
    @IBAction func setupButtonTapped(_ sender: UIButton) {
        delegate?.weatherDisplayViewDidTapSetup(self)
    }
    
    // MARK: - view
    
    private func reloadView(for state: State) {
        switch state {
        case .needsSetup:
            setupView.isHidden = false
            errorView.isHidden = true
            displayView.isHidden = true
        case .permitted(let message):
            setupView.isHidden = true
            errorView.isHidden = true
            displayView.isHidden = false
            displayLabel.text = message
        case .error(let message):
            setupView.isHidden = true
            errorView.isHidden = false
            errorLabel.text = message
            displayView.isHidden = true
        }
    }
}
