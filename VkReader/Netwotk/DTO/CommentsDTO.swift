//
//  CommentsDTO.swift
//  VkReader
//
//  Created by  Alex on 17.12.2020.
//

import Foundation

import Foundation

// MARK: - CommentDTO
struct CommentDTO: Codable {
    let response: CommentResponse?
}

// MARK: - Response
struct CommentResponse: Codable {
    let count: Int?
    let items: [CommentItem]?
    let profiles: [CommentProfile]?
}

// MARK: - Item
struct CommentItem: Codable {
    let id, fromID, date: Int?
    let text: String?
    let likes: CommentLikes?
    let attachments: [CommentAttachment]?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case date, text, likes, attachments
    }
}

// MARK: - Attachment
struct CommentAttachment: Codable {
    let type: String?
    let photo: CommentPhoto?
}

// MARK: - Photo
struct CommentPhoto: Codable {
    let id, albumID, ownerID: Int?
    let photo75, photo130, photo604: String?
    let width, height: Int?
    let text: String?
    let date: Int?
    let accessKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case width, height, text, date
        case accessKey = "access_key"
    }
}

// MARK: - Likes
struct CommentLikes: Codable {
    let count, userLikes, canLike: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
    }
}

// MARK: - Profile
struct CommentProfile: Codable {
    let id: Int?
    let firstName, lastName: String?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let online: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
    }
}
