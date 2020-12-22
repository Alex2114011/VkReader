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
    static func makeModel(with item: WallItem, and group: WallGroup) -> VKReaderViewModelCell {
        if let attachments = item.attachments, attachments.first?.type == "photo" {
            return WallPostWithImageCellViewModel(with: item, and: group)
        } else {
            return WallPostOnlyTextCellViewModel(with: item, and: group)
        }
    }
}
