//
//  WallPostWithImageCellViewModel.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import UIKit

class VKReaderSection: VKReaderSectionModel {
    var title: String = ""
    
    var headerHeight: CGFloat = 0
    
    var sortRate: Int = 0
    
    var cellsViewModel: [VKReaderViewModelCell] = []
    
    func headerIdentifier() -> String {
        return ""
    }
}

class WallPostWithImageCellViewModel: VKReaderViewModelCell {
    
    private var dynamicHeight: CGFloat = 0
    
    var item: Item
    var group: Group
    var imageURLString: String
    var imageHeigth: CGFloat
    var text: String
    
    init(with item: Item, and group: Group) {
        self.item = item
        self.group = group
        self.text = item.text ?? ""
        self.imageURLString = item.attachments?.first?.photo?.sizes?.last?.url ?? ""
        imageHeigth = CGFloat(item.attachments?.first?.photo?.sizes?.last?.height ?? 0) / UIScreen.main.scale
        if imageHeigth < UIScreen.main.bounds.width {
            imageHeigth = UIScreen.main.bounds.width
        }
    }
    
    func cellIdentifier() -> String {
        return String(describing: WallPostWithImageCollectionCell.self)
    }
    
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(177)
    }
    
    func heightIsCounted() -> Bool {
        if dynamicHeight == 0 {
            return false
        }
        return true
    }
    
    func change(height value: CGFloat) {
        if dynamicHeight == 0 {
            dynamicHeight = value
        }
    }
}
