//
//  WallDTO.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import Foundation

// MARK: - WallDTO
struct WallDTO: Codable {
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let count: Int?
    let items: [Item]?
    let groups: [Group]?
}

// MARK: - Group
struct Group: Codable {
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

// MARK: - Item
struct Item: Codable {
    let id, fromID, ownerID, date: Int?
    let markedAsAds: Int?
    let postType, text: String?
    let isPinned: Int?
    let attachments: [Attachment]?
    let postSource: PostSource?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let isFavorite: Bool?
    let donut: Donut?
    let shortTextRate: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case ownerID = "owner_id"
        case date
        case markedAsAds = "marked_as_ads"
        case postType = "post_type"
        case text
        case isPinned = "is_pinned"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case donut
        case shortTextRate = "short_text_rate"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let photo: Photo?
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let accessKey: String?
    let postID: Int?
    let sizes: [Size]?
    let text: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String?
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}
