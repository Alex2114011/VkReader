//
//  WallPostOnlyTextCellViewModel.swift
//  VkReader
//
//  Created by Alex on 30.11.2020.
//

import UIKit
///Модель для ячейки без текста
class WallPostOnlyTextCellViewModel: VKReaderViewModelCell {
    
    private var dynamicHeight: CGFloat = 0
    
    var item: Item
    var group: Group
    var text: String
    
    init(with item: Item, and group: Group) {
        self.item = item
        self.group = group
        self.text = item.text ?? ""
    }
    
    func cellIdentifier() -> String {
        return String(describing: WallPostOnlyTextCollectionViewCell.self)
    }
    
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(100)
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


