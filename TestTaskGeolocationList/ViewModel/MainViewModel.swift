//
//  MainViewModel.swift
//  TestTaskGeolocationList
//
//  Created by Panchenko Oleg on 28.03.2023.
//

import CoreLocation
import Foundation

final class MainViewModel: MainViewModelProtocol {
  
    var selectedRow: Int? = nil {
        didSet {
            guard selectedRow != nil else { return }
            self.selectedUser = usersArray.remove(at: selectedRow!)
        }
    }
    
    private var selectedUser: User? {
        didSet {
            if oldValue != nil { usersArray.append(oldValue!) }
            updateLocations()
        }
    }
    private var usersArray: [User]! 
    
    var users: ((User?, [User]) -> Void)?

    var dataManager: DataManagerProtocol!
    var locationManager: CLLocationManager?
    
    // MARK: - Data management
    private func startFetch() {
        usersArray = dataManager.getUsers()
    }
    
    func uncheckUser() {
        selectedRow = nil
        selectedUser = nil
        updateLocations()
    }
    
    // MARK: - Getting Locations
    public func updateLocations() {
        if selectedUser == nil && selectedRow == nil {
            startFetch()
            usersArray = updateGeolocations(users: usersArray)
            self.users?(nil, usersArray)
        } else {
            usersArray = updateGeolocations(users: usersArray, selectedUser: selectedUser)
            self.users?(selectedUser, usersArray)
        }
    }
    
    private func updateGeolocations(users: [User], selectedUser: User? = nil) -> [User] {
        let updatedUsers = users.map { user in
            var user = user
            user.latitude = Double.random(in: -90...90)
            user.longitude = Double.random(in: -180...180)
            user.distanceBetweenUsers = self.calculateDistance(user: user, to: selectedUser)
            return user
        }
        return updatedUsers
    }
    
     public func startUpdatingLocations() {
        locationManager?.startUpdatingLocation()
        updateLocations()
    }
    
    // MARK: - Distance Calculation
    private func calculateDistance(user: User, to selectedUser: User? = nil) -> Double {
        let userLocation = CLLocation(latitude: user.latitude, longitude: user.longitude)
        guard let selectedUser = selectedUser else {
            guard let currentLocation = locationManager?.location else {
                return 0.0
            }
            let distance = userLocation.distance(from: currentLocation)
            return distance / 1000
        }
        let selectedUserLocation = CLLocation(latitude: selectedUser.latitude, longitude: selectedUser.longitude)
        let distance = userLocation.distance(from: selectedUserLocation)
        return distance / 1000
    }
}
