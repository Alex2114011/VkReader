//
//  CommentsDTO.swift
//  VkReader
//
//  Created by  Alex on 17.12.2020.
//

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
//    let groups: [JSONAny]
    let currentLevelCount: Int?
    let canPost, showReplyButton, groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count, items, profiles//, groups
        case currentLevelCount = "current_level_count"
        case canPost = "can_post"
        case showReplyButton = "show_reply_button"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Item
struct CommentItem: Codable {
    let id, fromID, postID, ownerID: Int?
//    let parentsStack: [JSONAny]
    let date: Int?
    let text: String?
    let likes: CommentLikes?
    let attachments: [CommentAttachment]?
    let thread: CommentThread?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case postID = "post_id"
        case ownerID = "owner_id"
//        case parentsStack = "parents_stack"
        case date, text, likes, attachments, thread
    }
}

// MARK: - Attachment
struct CommentAttachment: Codable {
    let type: String?
    let photo: CommentPhoto?
}

// MARK: - Photo
struct CommentPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let accessKey: String?
    let sizes: [CommentSize]?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case sizes, text
    }
}

// MARK: - Size
struct CommentSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

// MARK: - Likes
struct CommentLikes: Codable {
    let count, userLikes, canLike: Int?
    let canPublish: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - Thread
struct CommentThread: Codable {
    let count: Int?
//    let items: [JSONAny]
    let canPost, showReplyButton, groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count//, items
        case canPost = "can_post"
        case showReplyButton = "show_reply_button"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Profile
struct CommentProfile: Codable {
    let firstName: String?
    let id: Int?
    let lastName: String?
    let canAccessClosed, isClosed: Bool?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let onlineInfo: CommentOnlineInfo?
    let online: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
    }
}

// MARK: - OnlineInfo
struct CommentOnlineInfo: Codable {
    let visible: Bool?
    let lastSeen: Int?
    let isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}












//import Foundation
//
//// MARK: - CommentDTO
//struct CommentDTO: Codable {
//    let response: CommentResponse?
//}
//
//// MARK: - Response
//struct CommentResponse: Codable {
//    let count: Int?
//    let items: [CommentItem]?
//    let profiles: [CommentProfile]?
//}
//
//// MARK: - Item
//struct CommentItem: Codable {
//    let id, fromID, date: Int?
//    let text: String?
//    let likes: CommentLikes?
//    let attachments: [CommentAttachment]?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case fromID = "from_id"
//        case date, text, likes, attachments
//    }
//}
//
//// MARK: - Attachment
//struct CommentAttachment: Codable {
//    let type: String?
//    let photo: CommentPhoto?
//}
//
//// MARK: - Photo
//struct CommentPhoto: Codable {
//    let id, albumID, ownerID: Int?
//    let photo75, photo130, photo604: String?
//    let width, height: Int?
//    let text: String?
//    let date: Int?
//    let accessKey: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumID = "album_id"
//        case ownerID = "owner_id"
//        case photo75 = "photo_75"
//        case photo130 = "photo_130"
//        case photo604 = "photo_604"
//        case width, height, text, date
//        case accessKey = "access_key"
//    }
//}
//
//// MARK: - Likes
//struct CommentLikes: Codable {
//    let count, userLikes, canLike: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userLikes = "user_likes"
//        case canLike = "can_like"
//    }
//}
//
//// MARK: - Profile
//struct CommentProfile: Codable {
//    let id: Int?
//    let firstName, lastName: String?
//    let sex: Int?
//    let screenName: String?
//    let photo50, photo100: String?
//    let online: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case sex
//        case screenName = "screen_name"
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//        case online
//    }
//}
