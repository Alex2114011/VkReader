//
//  UserGroupsCollectionViewCellModel.swift
//  VkReader
//
//  Created by Alex on 11.01.2021.
//

import UIKit
class UserGroupsCollectionViewCellModel: VKReaderViewModelCell {
    
    private var dynamicHeight: CGFloat = 0
    
    var item: GroupsItem
    var imageURLString: String
    var name: String
//    var imageSize: CGFloat
    
    init(with item: GroupsItem) {
        self.item = item
        self.name = item.name ?? ""
        self.imageURLString = item.photo100 ?? ""
    }
    
    func cellIdentifier() -> String {
        return String(describing: UserGroupsCollectionViewCell.self)
    }
    
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(123)
    }
    
    func heightIsCounted() -> Bool {
        if dynamicHeight == 0 {
            return false
        }
        return true
    }
    
    func formatNumber(_ n: Int) -> String {
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"
        }
    }
    
}