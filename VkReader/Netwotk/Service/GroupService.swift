//
//  GroupService.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation

protocol GroupService {
    func getUserGroups(for userID: Int, count: Int, callback: @escaping ((LoadingResult<GroupsDTO>) -> Void))
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
//    params[user_id]=248758944&params[extended]=1&params[count]=10&params[v]=5.126
//    func getRecomendGroups(categoryId:Int?, subcategoryID: Int?, callback: @escaping ((LoadingResult<GroupsDTO>) -> Void)) {
//        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
//        let parameters = ["category_id":"\(categoryId)","subcategoryID":"\(subcategoryID)" ,"access_token": token, "v": "5.126"]
//        baseNetworkService.sendRequest(url: urlProvider.groupsGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
//    }
    
    
}
