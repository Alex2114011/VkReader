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
    func getGroups()
    func nextPage()
}

class GroupsViewModelImpl: GroupsViewModel {
 
    weak var delegate: GroupsViewDelegate?
    
    var sections: [VKReaderSectionModel] = []
    var index: Int?
    var userID:Int = 0
    
    let accountService: AccountService
    let groupService: GroupService
    
    init(groupService: GroupService, accountService: AccountService) {
        self.groupService = groupService
        self.accountService = accountService
    }
 
    
    func set(delegate: GroupsViewDelegate) {
        self.delegate = delegate
    }
    
    func getAccount() {
        accountService.getAccount { [weak self](result) in
            print(#function)
            guard let self = self else {return}
            switch result{
            case.success(let dto):
                guard let accountID = dto.response.id else { return }
                self.userID = accountID
                print("userID \(self.userID)")
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }

    
    func getGroups() {
        groupService.getUserGroups(for: userID, count: 10) { [weak self](result) in
            print(#function)
            guard let self = self else { return }
            print(self.userID)
            switch result {
            case .success(let dto):
                var models: [VKReaderViewModelCell] = []
                dto.response?.items?.forEach({
                    models.append(VKReaderFactory.makeGroupsModel(with: $0))
                })
                let section = VKReaderSection()
                section.cellsViewModel = models
                self.sections = [section]
                self.delegate?.reloadData()
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
   
    func nextPage() {
        
    }
}
