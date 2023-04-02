//
//  DataManager.swift
//  TestTaskGeolocationList
//
//  Created by Panchenko Oleg on 28.03.2023.
//

import UIKit

final class DataManager: DataManagerProtocol {
    
    func getUsers() -> [User] {
        let users: [User] = [
            User(name: "Robert", profileImage: "Robert", latitude: 30.11, longitude: 55.23),
            User(name: "Vladimir", profileImage: "Vladimir", latitude: 30.11, longitude: 55.23),
            User(name: "Sarah", profileImage: "Sarah", latitude: 30.11, longitude: 55.23),
            User(name: "Michelle", profileImage: "Michelle", latitude: 30.11, longitude: 55.23),
            User(name: "Leonard", profileImage: "Leonard", latitude: 30.11, longitude: 55.23),
            User(name: "Olivia", profileImage: "Olivia", latitude: 30.11, longitude: 55.23),
            User(name: "Christina", profileImage: "Christina", latitude: 30.11, longitude: 55.23),
            User(name: "John", profileImage: "John", latitude: 30.11, longitude: 55.23),
            User(name: "Victoria", profileImage: "Victoria", latitude: 30.11, longitude: 55.23)
        ]
        return users
    }
}
