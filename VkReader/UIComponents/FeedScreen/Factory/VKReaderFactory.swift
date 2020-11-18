//
//  VKReaderFactory.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import Foundation

class VKReaderFactory {
    static func makeModel(with item: Item, and group: Group) -> VKReaderViewModelCell {
        if let attachments = item.attachments, attachments.first?.type == "photo" {
            return WallPostWithImageCellViewModel(with: item, and: group)
        } else {
            return WallPostCellViewModel(with: item, and: group)
        }
    }
}
