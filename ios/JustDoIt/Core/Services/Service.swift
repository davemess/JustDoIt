//
//  Service.swift
//  JustDoIt
//
//  Created by David Messing on 4/1/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Identifies an external service.
protocol Service {}

/// Identifies a service that is expected to be started during application launch.
protocol LaunchService: Service {
    func initialize(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
}
