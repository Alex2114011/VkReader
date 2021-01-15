//
//  GroupService.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation

protocol GroupService {
    func getUserGroups(for userID: Int, count: Int, callback: @escaping ((LoadingResult<GroupsDTO>) -> Void))
    func getCatalogGroups( callback: @escaping ((LoadingResult<GroupsDTO>) -> Void))
    func getGroupsInfo(for groupIDs:[Int], callback: @escaping ((LoadingResult<GroupInfoDTO>) -> Void))
}

class GroupServiceImpl: GroupService {

    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider
    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }
/// в методе указавываем параметры запроса к апи, эти параметры передаем в baseNetworkService
    func getUserGroups(for userID: Int, count: Int, callback: @escaping ((LoadingResult<GroupsDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["user_id": "\(userID)", "count": "\(count)", "access_token": token, "v": "5.126", "extended": "1"]
        baseNetworkService.sendRequest(url: urlProvider.groupsGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
    }
    
    func getCatalogGroups( callback: @escaping ((LoadingResult<GroupsDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["access_token": token, "v": "5.126"]
        baseNetworkService.sendRequest(url: urlProvider.groupsGetCatalog, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
    }
    
    func getGroupsInfo(for groupIDs:[Int], callback: @escaping ((LoadingResult<GroupInfoDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["group_ids":"\(groupIDs)","count":"0", "fields":"status,members_count,activity", "access_token": token, "v": "5.126"]
        baseNetworkService.sendRequest(url: urlProvider.groupsInfoGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
    }
}
