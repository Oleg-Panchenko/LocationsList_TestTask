//
//  User.swift
//  TestTaskGeolocationList
//
//  Created by Panchenko Oleg on 28.03.2023.
//

import Foundation

struct User: Equatable {
    var name: String
    let profileImage: String
    var latitude: Double
    var longitude: Double
    var distanceBetweenUsers: Double?
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
}


