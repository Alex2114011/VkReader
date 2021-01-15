//
//  ContainerCollectionViewCellModel.swift
//  VkReader
//
//  Created by Alex on 15.01.2021.
//

import UIKit

protocol ContainerCollectionViewCellModel{
    var viewModel:GroupsViewModel {get}
}

class ContainerCollectionViewCellModelImpl: VKReaderViewModelCell, ContainerCollectionViewCellModel{
    private var dynamicHeight: CGFloat = 0
    
    let viewModel:GroupsViewModel
    
    init(viewModel:GroupsViewModel) {
        self.viewModel = viewModel
    }

    func cellIdentifier() -> String {
        String(describing: ContainerCollectionViewCell.self)
    }
    
    func height() -> VKReaderCellHeight {
        if dynamicHeight != 0 {
            return .value(dynamicHeight)
        }
        return .value(150)
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
