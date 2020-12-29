//
//  PostOnlyTextCellViewModel.swift
//  VkReader
//
//  Created by Alex on 27.12.2020.
//

import UIKit

class PostOnlyTextCellViewModel: VKReaderViewModelCell {
    
    
    private var dynamicHeight: CGFloat = 0
    
    var item: CommentItem
    var profile: CommentProfile
    var text: String
    var likeCounts: Int
//    var commentsCount: Int
//    var viewsCount: Int
    
    
    init(with item: CommentItem, and profile: CommentProfile) {
        self.item = item
        self.profile = profile
        self.text = item.text ?? ""
        self.likeCounts = item.likes?.count ?? 0
//        self.commentsCount = item.comments?.count ?? 0
//        self.viewsCount = item.views?.count ?? 0
    }
    
    func cellIdentifier() -> String {
        return String(describing: PostOnlyTextCollectionViewCell.self)
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
