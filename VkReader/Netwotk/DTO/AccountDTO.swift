//
//  AccountDTO.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation

// MARK: - Account
struct AccountDTO: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let firstName: String?
    let id: Int?
    let lastName, homeTown, status, bdate: String?
    let bdateVisibility: Int?
    let city, country: City
    let phone: String?
    let relation, sex: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case homeTown = "home_town"
        case status, bdate
        case bdateVisibility = "bdate_visibility"
        case city, country, phone, relation, sex
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let title: String?
}
