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
    var commentsCount: Int
    var dateCreateComment: Double
    
    
    init(with item: CommentItem, and profile: CommentProfile) {
        self.item = item
        self.profile = profile
        self.text = item.text ?? ""
        self.commentsCount = item.likes?.count ?? 0
        self.dateCreateComment = Double(item.date ?? 0)
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
    
  
    func formatDate(from unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateStyle = .medium
        let dateAsString = dateFormatter.string(from: date as Date)
        let dateFromString = dateFormatter.date(from: dateAsString)
        let dateCreateComment = dateFormatter.string(from: dateFromString! )
        return dateCreateComment
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
