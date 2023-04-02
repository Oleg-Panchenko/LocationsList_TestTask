//
//  MainViewModelProtocol.swift
//  TestTaskGeolocationList
//
//  Created by Panchenko Oleg on 03.04.2023.
//

import CoreLocation
import Foundation

protocol MainViewModelProtocol {
    var users: ((User?, [User]) -> Void)? { get set }
    var selectedRow: Int? { get set }
    var locationManager: CLLocationManager? { get set }
    func updateLocations()
    func startUpdatingLocations()
    func uncheckUser()
}
