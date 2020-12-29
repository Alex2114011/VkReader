//
//  PostWithImageCellViewModel.swift
//  VkReader
//
//  Created by Alex on 27.12.2020.
//

import UIKit
/// создаем секции
//class VKReaderSection: VKReaderSectionModel {
//    var title: String = ""
//
//    var headerHeight: CGFloat = 0
//
//    var sortRate: Int = 0
//
//    var cellsViewModel: [VKReaderViewModelCell] = []
//
//    func headerIdentifier() -> String {
//        return ""
//    }
    

//}
/// модель для ячейки с картинкой
class PostWithImageCellViewModel: VKReaderViewModelCell {
    
    private var dynamicHeight: CGFloat = 0
    
    var item: CommentItem
    var profile: CommentProfile
    var imageURLString: String
    var imageHeigth: CGFloat
    var imageWidth: CGFloat
    var text: String

    
    init(with item: CommentItem, and profile: CommentProfile) {
        self.item = item
        self.profile = profile
        self.text = item.text ?? ""

        self.imageURLString = item.attachments?.first?.photo?.sizes?.last?.url ?? ""
        self.imageHeigth = CGFloat(item.attachments?.first?.photo?.sizes?.last?.height ?? 0) / UIScreen.main.scale
        self.imageWidth = CGFloat(item.attachments?.first?.photo?.sizes?.last?.width ?? 0) / UIScreen.main.scale

        if imageHeigth > UIScreen.main.bounds.width {
            imageHeigth = UIScreen.main.bounds.width
        }
        if imageWidth > UIScreen.main.bounds.width {
            imageWidth = UIScreen.main.bounds.width
        }
    }
    /// Возвращает идентификатор ячейки
    func cellIdentifier() -> String {
        return String(describing: PostWithImageCollectionViewCell.self)
    }
    /// востота ячейки
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(177)
    }
    /// посчитали высоту если равна нулю то не отображаем ячейку
    func heightIsCounted() -> Bool {
        if dynamicHeight == 0 {
            return false
        }
        return true
    }
    /// изменяем высоту ячейку
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

