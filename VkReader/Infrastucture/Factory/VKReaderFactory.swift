//
//  VKReaderFactory.swift
//  VkReader
//
//  Created by Alex on 30.11.2020.
//

import Foundation
/// Фабрика ячеек
/// определяем количество постов и групп, возвращаем ячейку определенного типа, если в модели есть фото то возвращаем WallPostWithImageCellViewModel если нет то ячейку без текста
class VKReaderFactory {
    static func makeWallModel(with item: WallItem, and group: WallGroup) -> VKReaderViewModelCell {
        if let attachments = item.attachments, attachments.first?.type == "photo" {
            return WallPostWithImageCellViewModel(with: item, and: group)
        } else {
            return WallPostOnlyTextCellViewModel(with: item, and: group)
        }
    }
    static func makeCommentModel(with item: CommentItem, and profile: CommentProfile) -> VKReaderViewModelCell {
        if let attachments = item.attachments, attachments.first?.type == "photo" {
            return PostWithImageCellViewModel(with: item, and: profile)
        } else {
            return PostOnlyTextCellViewModel(with: item, and: profile)
        }
    }
    static func makeUserGroupsModel(with item: GroupsItem) -> VKReaderViewModelCell {
        if let attachments = item.isMember, attachments == 1 {
            return ContainerCollectionViewCellModel(with: item)
        } else {
            return ContainerCollectionViewCellModel(with: item)
        }
    }
    static func makeGroupsModel(with item: GroupInfoResponse) -> VKReaderViewModelCell {
        if let attachments = item.isMember, attachments == 1 {
            return CatalogGroupsCollectionViewCellModel(with: item)
        } else {
            return CatalogGroupsCollectionViewCellModel(with: item)
        }
    }
}
