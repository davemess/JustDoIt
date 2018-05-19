//
//  AbstractCoordinator.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Coordinators are responsible for directing view controller flow within an application.
protocol AbstractCoordinator: class {
    
    var navigationController: UINavigationController { get }
    var childCoordinators: [AbstractCoordinator] { get set }
    
    /**
     Called to kick off coordinator operations.
     */
    func start(_ animated: Bool)
}
