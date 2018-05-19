//
//  AppFactory.swift
//  JustDoIt
//
//  Created by David Messing on 4/1/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Core factory for producing components necessary for app launch and run.
class AppFactory {
    
    // MARK: - properties
    
    var launchServices: [LaunchService] {
        let launchServices = appServices.services.filter { $0 is LaunchService }
        return launchServices as! [LaunchService]
    }
    
    private let appServices: AppServices
    
    // MARK: - lifecyle
    
    init(_ appServices: AppServices) {
        self.appServices = appServices
    }
}
