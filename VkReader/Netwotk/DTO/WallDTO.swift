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
    let response: Response?
}
// все дальнейшие дествия нацелены на то что бы создать структуру JSON в нашей модели данных.

struct Response: Codable {
    let count: Int?
    let posts: [Post]?
    let groups: [Group]?
}
//MARK: Group
///Структура которая содержит в себе данные о группе
struct Group: Codable {
   let id: Int?
   let name: String?
   let screenName: String?
   let isClosed: Int?
   let type: String?
   let isAdmin: Int?
   let isMember: Int?
   let isAdvertiser: Int?
   let photo50, photo100, photo200: String?
   
    ///Перечисление в котором содержатся название полей в json.  CodingKey это протокол который позволяет импользовать это перечисление как ключ для кодирования и декодирования
    enum CodingKeys: String, CodingKey {
        case id
        case name
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

//MARK: POST
struct Post: Codable {
    let id, fromId, ownerId, date, isPinned, marketAsAds: Int?
    let postType, text: String?
    let attachments: [Attachment]?
    let postSource: [PostSource]?
    let comments: [Comment]?
    let likes: [Like]?
    let reposts: [Repost]?
    let views: Views?
    let isFavorite: Bool?
    let shortTextRate: Double?
    let carouselOffset: Double?
    let donut: Donut?
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
        case donut
        case isPinned = "is_pinned"
        case fromId = "from_id"
        case ownerId = "owner_id"
        case marketAsAds = "marked_as_ads"
        case postType = "post_type"
        case postSource = "post_source"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case carouselOffset = "carousel_offset"
        
    }
}

//MARK: Attachment
struct Attachment: Codable {
    let type: String?
    let photo: Photo?
}

//MARK: Photo
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

//MARK: Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: String?
}

//MARK: PostSource
struct PostSource:Codable {
    let type: String?
}

//MARK: Comment
struct Comment: Codable {
    let count: Int?
    let canPost: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

//MARK: Like
struct Like: Codable {
    let count, userLikes, canLike, canPublish: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

//MARK: Repost
struct Repost: Codable {
    let count, userReposted: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

//MARK: Views
struct Views: Codable {
    let count: Int?
}

//MARK: Donut
struct Donut: Codable{
    let isDonut: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

