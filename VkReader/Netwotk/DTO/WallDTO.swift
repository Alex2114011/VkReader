//
//  WallDTO.swift
//  VkReader
//
//  Created by Alex on 24.11.2020.
//

import Foundation

//MARK: WallDTO
/// WallDTO В константе этой структуры  содержатся все элементы данных.
/// Для определения какие данные возвращает апи обращаемся к документации
/// https://vk.com/dev/wall.get-  для получения постов на стене
/// https://vk.com/dev/groups.get - для получения данных о группе
struct WallDTO: Codable {
    let response: WallResponse?
}

// MARK: - Response
// все дальнейшие дествия нацелены на то что бы создать структуру JSON в нашей модели данных.
struct WallResponse: Codable {
    let count: Int?
    let items: [WallItem]?
    let groups: [WallGroup]?
}

// MARK: - Group
///Структура которая содержит в себе данные о группе
struct WallGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?
    ///Перечисление в котором содержатся название полей в json.  CodingKey это протокол который позволяет импользовать это перечисление как ключ для кодирования и декодирования
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
struct WallItem: Codable {
    let id, fromID, ownerID, date: Int?
    let markedAsAds: Int?
    let postType, text: String?
    let isPinned: Int?
    let attachments: [WallAttachment]?
    let postSource: WallPostSource?
    let comments: WallComments?
    let likes: WallLikes?
    let reposts: WallReposts?
    let views: WallViews?
    let isFavorite: Bool?
    let donut: WallDonut?
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
struct WallAttachment: Codable {
    let type: String?
    let photo: WallPhoto?
}

// MARK: - Photo
struct WallPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let accessKey: String?
    let postID: Int?
    let sizes: [WallSize]?
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
struct WallSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

// MARK: - Comments
struct WallComments: Codable {
    let count, canPost: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Donut
struct WallDonut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct WallLikes: Codable {
    let count, userLikes, canLike, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct WallPostSource: Codable {
    let type: String?
}

// MARK: - Reposts
struct WallReposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct WallViews: Codable {
    let count: Int?
}
