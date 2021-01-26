//
//  ContainerCollectionViewCellModel.swift
//  VkReader
//
//  Created by Alex on 15.01.2021.
//

import UIKit

class ContainerArrayWrapperCellViewModel: VKReaderViewModelCell {
    var items: [ContainerCollectionViewCellModel]
    
    private var dynamicHeight: CGFloat = 0
    
    
    init(with items: [VKReaderViewModelCell]) {
        guard let unwrapItems = items as? [ContainerCollectionViewCellModel] else { fatalError("wrong format") }
        self.items = unwrapItems
    }
    
    func cellIdentifier() -> String {
        return String(describing: ContainerCollectionViewCell.self)
    }
    
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(120)
    }
    
    func heightIsCounted() -> Bool {
        if dynamicHeight == 0 {
            return false
        }
        return true
    }
    
    func formatNumber(_ n: Int) -> String {
        return ""
    }
}

class ContainerCollectionViewCellModel: VKReaderViewModelCell {
    
    var item: GroupsItem
    
    private var dynamicHeight: CGFloat = 0
    
    
    init(with item: GroupsItem) {
        self.item = item
    }
    
    func cellIdentifier() -> String {
        return String(describing: ContainerCollectionViewCell.self)
    }
    
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(140)
    }
    
    func heightIsCounted() -> Bool {
        if dynamicHeight == 0 {
            return false
        }
        return true
    }
    
    func formatNumber(_ n: Int) -> String {
        return ""
    }
    
}
