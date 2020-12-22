//
//  WallPostWithImageCellViewModel.swift
//  VkReader
//
//  Created by Alex on 30.11.2020.
//

import UIKit
/// создаем секции
class VKReaderSection: VKReaderSectionModel {
    var title: String = ""
    
    var headerHeight: CGFloat = 0
    
    var sortRate: Int = 0
    
    var cellsViewModel: [VKReaderViewModelCell] = []
    
    func headerIdentifier() -> String {
        return ""
    }
    

}
/// модель для ячейки с картинкой
class WallPostWithImageCellViewModel: VKReaderViewModelCell {
    
    private var dynamicHeight: CGFloat = 0
    
    var item: WallItem
    var group: WallGroup
    var imageURLString: String
    var imageHeigth: CGFloat
    var imageWidth: CGFloat
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
        self.imageURLString = item.attachments?.first?.photo?.sizes?.last?.url ?? ""
        self.imageHeigth = CGFloat(item.attachments?.first?.photo?.sizes?.last?.height ?? 0) / UIScreen.main.scale
        self.imageWidth = CGFloat(item.attachments?.first?.photo?.sizes?.last?.width ?? 0) / UIScreen.main.scale
//        print("Высота \(imageHeigth)")
        if imageHeigth > UIScreen.main.bounds.width {
            imageHeigth = UIScreen.main.bounds.width
        }
        if imageWidth > UIScreen.main.bounds.width {
            imageWidth = UIScreen.main.bounds.width
        }
    }
    /// Возвращает идентификатор ячейки
    func cellIdentifier() -> String {
        return String(describing: WallPostWithImageCollectionViewCell.self)
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

