//
//  TodoListViewController.swift
//  JustDoIt
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNAppKit
import AFNUIUtilities
import JDIKit
import AFNPermissions
import WeatherService
import CoreLocation

/// Defines callbacks on TodoListViewController.
protocol TodoListViewControllerDelegate: class {
    func listViewControllerDidSelectAdd(_ viewController: TodoListViewController)
}

extension TodoListViewController: ErrorAlertRenderer, PermissionPromptController {}

/// Displays a list of Todo Items.
class TodoListViewController: UIViewController {
    
    private struct Selector {
        static let add = #selector(addActionSelected)
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var weatherDisplayView: WeatherDisplayView!
    
    private let itemManager: ItemManager
    private let dataSource: ItemListDataSource
    private let locationManager: CLLocationManager
    private let weatherService: WeatherService
    
    weak var delegate: TodoListViewControllerDelegate?
    
    // MARK: - lifecycle
    
    init(itemManager: ItemManager, locationManager: CLLocationManager, weatherService: WeatherService) {
        let query = AFNQuery(constraints: [
            .sort(key: "isDone", order: .ascending),
            .sort(key: "content", order: .ascending),
            ])
        let queryRef: AFNPageRef<Item> = AFNPageRef(query: query)
        
        self.itemManager = itemManager
        self.dataSource = itemManager.listDataSource(queryRef: queryRef)
        self.locationManager = locationManager
        self.weatherService = weatherService
        
        super.init(nibName: nil, bundle: nil)
        
        self.dataSource.delegate = self
        self.locationManager.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureViewController()
        
        reloadData()
    }
    
    // MARK: - view
    
    private func configureView() {
        tableView.registerReusableCell(ItemTableViewCell.self)
        tableView.decelerationRate = UIScrollViewDecelerationRateFast
        
        weatherDisplayView.layer.shadowColor = UIColor(white: 0.0, alpha: 0.55).cgColor
        weatherDisplayView.layer.shadowRadius = 3.0
        weatherDisplayView.layer.shadowOffset = CGSize(width: 0, height: -3)
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let barButtonItemFactory = BarButtonItemFactory()
        let addItem = barButtonItemFactory.addItem(self, action: Selector.add)
        
        navigationItem.rightBarButtonItem = addItem
        
        self.title = NSLocalizedString("Today", comment: "")
        
        weatherDisplayView.delegate = self
    }
    
    // MARK: - data
    
    private func reloadData() {
        dataSource.reloadData(success: { (result) in
            self.handleLoad(result)
        }) { (error) in
            self.handleError(error)
        }
        
        reloadWeather()
    }
    
    private func handleLoad(_ results: [Item]) {
        tableView.reloadData()
    }
    
    private func handleError(_ error: Error) {
        self.present(error)
    }
    
    private func toggleDoneState(_ item: Item) {
        item.toggleDone()
        itemManager.save(item, success: { (item) in
            // empty implementation
        }) { (error) in
            self.present(error)
        }
    }
    
    private func reloadWeather() {
        let status = permissionStatus(.location)
        switch status {
        case .denied, .unknown:
            weatherDisplayView.state = .needsSetup
        case .permitted:
            weatherDisplayView.state = .permitted(message: "Loading Current Weather...")
            reloadLocationData()
        }
    }
    
    private func reloadLocationData() {
        locationManager.startUpdatingLocation()
    }
    
    private func reloadWeatherData(_ coordinate: CLLocationCoordinate2D) {
        weatherService.getWeather(at: coordinate, success: { (weather) in
            let message: String
            if let temp = weather.temperature {
                let convertedTemp = Measurement(value: temp.value, unit: UnitTemperature.kelvin)
                let temperatureString = MeasurementFormatter().string(from: convertedTemp)
                message = String.localizedStringWithFormat(NSLocalizedString("Current temperature is %@", comment: ""), temperatureString)
            } else {
                message = NSLocalizedString("Current temperature is unavailable.", comment: "")
            }
            
            self.weatherDisplayView.state = .permitted(message: message)
        }) { (error) in
            self.weatherDisplayView.state = .error(message: error.localizedDescription)
        }
    }
    
    // MARK: - actions
    
    @objc private func addActionSelected() {
        self.delegate?.listViewControllerDidSelectAdd(self)
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = dataSource.item(at: indexPath)
        cell.configure(with: item)
        cell.delegate = self
        
        return cell
    }
}

extension TodoListViewController: ItemListDataSourceDelegate {
    
    func itemListDataSourceDidReload(_ dataSource: ItemListDataSource) {
        tableView.reloadData()
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didInsert item: Item, at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didDelete item: Item, at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didUpdate item: Item, at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func itemListDataSource(_ dataSource: ItemListDataSource, didMove item: Item, at indexPath: IndexPath, to newIndexPath: IndexPath) {
        tableView.moveRow(at: indexPath, to: newIndexPath)
        tableView.reloadRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
    }
}

extension TodoListViewController: ItemTableViewCellDelegate {
    
    func itemTableViewCellDidDidToggleItemDoneState(_ cell: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let item = dataSource.item(at: indexPath)
        toggleDoneState(item)
    }
}

extension TodoListViewController: WeatherDisplayViewDelegate {
    
    func weatherDisplayViewDidTapSetup(_ view: WeatherDisplayView) {
        let permission: Permission = .location
        self.checkPermissionWithPromptIfNecessary(permission) { result in
            switch result {
            case .accepted:
                self.weatherDisplayView.state = .permitted(message: "Loading Current Weather...")
                self.reloadLocationData()
            case .denied(let permissionError):
                switch permissionError {
                case .notAccepted(_), .notGranted(_):
                    let errorMessage = permissionError.localizedDescription
                    self.weatherDisplayView.state = .error(message: errorMessage)
                case .restricted(_):
                    let errorMessage = NSLocalizedString("Location permission restricted.", comment: "")
                    self.weatherDisplayView.state = .error(message: errorMessage)
                }
            }
        }
    }
}

extension TodoListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        let coordinate = location.coordinate
        reloadWeatherData(coordinate)
    }
}
