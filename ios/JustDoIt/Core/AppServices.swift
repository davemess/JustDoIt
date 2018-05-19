//
//  AppServices.swift
//  JustDoIt
//
//  Created by David Messing on 4/1/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AFNAppKit

/// Core class for providing and configuring external services.
class AppServices {
    
    // MARK: - properties
    
    lazy var services: [Service] = {
        // INFO: Instantiate external services
        return []
    }()
    
    private var buildConfiguration: BuildConfiguration
    
    // MARK: - lifecycle
    
    init(_ buildConfiguration: BuildConfiguration) {
        self.buildConfiguration = buildConfiguration
    }
}
