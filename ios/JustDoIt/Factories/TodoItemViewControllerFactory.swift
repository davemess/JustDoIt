//
//  TodoItemViewControllerFactory.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import JDIKit
import WeatherService
import CoreLocation

/// Factory class for producing TodoItem view controllers.
class TodoItemViewControllerFactory {
    
    private let itemManager: ItemManager
    private let weatherService: WeatherService
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        return locationManager
    }()
    
    // MARK: - lifecycle
    
    init(itemManager: ItemManager, weatherService: WeatherService) {
        self.itemManager = itemManager
        self.weatherService = weatherService
    }

    // MARK: - public
    
    func todoListViewController() -> TodoListViewController {
        let viewController = TodoListViewController(itemManager: itemManager, locationManager: locationManager, weatherService: weatherService)
        
        return viewController
    }
    
    func todoCreateViewController() -> TodoCreateViewController {
        let viewController = TodoCreateViewController(itemManager: itemManager)
        
        return viewController
    }
}
