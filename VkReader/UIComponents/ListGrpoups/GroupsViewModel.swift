//
//  GroupsViewModel.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation

protocol GroupsViewDelegate: class {
    func reloadData()
    func update(with indexs: [IndexPath])
}

protocol GroupsViewModel {
    var sections: [VKReaderSectionModel] { get }
    var index:Int? {get set}

    
    func set(delegate: GroupsViewDelegate)
    func getAccount()
    func getGroupsCatalog()
    func nextPage()
    func getOwnerID(indexPath: Int) -> Int 
}

class GroupsViewModelImpl: GroupsViewModel {
 
    weak var delegate: GroupsViewDelegate?
    
    var sections: [VKReaderSectionModel] = []
    var index: Int?
    var userID:Int = 0
    var groupsIDArray:[Int] = []
    
    let accountService: AccountService
    let groupService: GroupService
    let wallService: WallService
    
    init(groupService: GroupService, accountService: AccountService, wallService: WallService) {
        self.groupService = groupService
        self.accountService = accountService
        self.wallService = wallService
    }
 
    
    func set(delegate: GroupsViewDelegate) {
        self.delegate = delegate
    }
    
    func getAccount() {
        accountService.getAccount {(result) in
            switch result{
            case.success(let dto):
                guard let accountID = dto.response.id else { return }
                self.userID = accountID
                self.groupService.getUserGroups(for: self.userID, count: 10) { [weak self](result) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let dto):
                        var models: [VKReaderViewModelCell] = []
                        dto.response?.items?.forEach({
                            models.append(VKReaderFactory.makeUserGroupsModel(with: $0))
                        })
                        let wrapper = ContainerArrayWrapperCellViewModel(with: models)
                        let section = VKReaderSection()
                        section.cellsViewModel = [wrapper]
                        self.sections = [section]
                        self.delegate?.reloadData()
                    case .failure(let error):
                        print(error?.localizedDescription ?? "")
                    }
                }
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }

    
    func getGroupsCatalog() {
        groupService.getCatalogGroups {(result) in
            switch result{
            case .success(let groupsDto):
                groupsDto.response?.items?.forEach({ (groupsItem) in
                    guard let groupId = groupsItem.id else {return}
                    self.groupsIDArray.append(groupId)
                })
                    self.groupService.getGroupsInfo(for: self.groupsIDArray) {[weak self] (result) in
                        guard let self = self else { return }
                        switch result {
                        case .success(let groupsInfoDTO):
                            var models: [VKReaderViewModelCell] = []
                            groupsInfoDTO.response?.forEach({ (groupInfoResponse) in
                                models.append(VKReaderFactory.makeGroupsModel(with: groupInfoResponse))
                            })
                            let section = VKReaderSection()
                            section.cellsViewModel = models
                            self.sections.append(section)
                            self.delegate?.reloadData()
                        case .failure(let error):
                                        print(error?.localizedDescription ?? "getGroupsInfo failure")
                        }
                    }
               
            case.failure(let error):
                print(error?.localizedDescription ?? "getCatalogGroups failure")
            }
        }
    }
    func nextPage() {
        
    }
    
    
    func getOwnerID(indexPath: Int) -> Int {
        let ownerID = self.groupsIDArray[indexPath + 1]
        return ownerID
    }
}

