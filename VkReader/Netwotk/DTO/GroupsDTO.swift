//
//  GroupsDTO.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation
// MARK: - Groups
struct GroupsDTO: Codable {
    let response: GroupsResponse?
}

// MARK: - Response
struct GroupsResponse: Codable {
    let count: Int?
    let items: [GroupsItem]?
}

// MARK: - Item
struct GroupsItem: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

