//
//  GroupService.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation

protocol GroupService {
    func getGroups(for userID: Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<GroupsDTO>) -> Void))
}

class GroupServiceImpl: GroupService {
    var userID: Int = 0
    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider
    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }
/// в методе указавываем параметры запроса к апи, эти параметры передаем в baseNetworkService
    func getGroups(for userID: Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<GroupsDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["user_id": "\(userID)", "count": "\(count)", "offset": "\(offset)", "access_token": token, "v": "5.126", "extended": "1"]
        baseNetworkService.sendRequest(url: urlProvider.wallGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)


    }
}
