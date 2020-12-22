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
    
    var item: WallItem
    var group: WallGroup
    var text: String
    var likeCounts: Int
    var commentsCount: Int
    var viewsCount: Int
    
    
    init(with item: WallItem, and group: WallGroup) {
        self.item = item
        self.group = group
        self.text = item.text ?? ""
        self.likeCounts = item.likes?.count ?? 0
        self.commentsCount = item.comments?.count ?? 0
        self.viewsCount = item.views?.count ?? 0
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


