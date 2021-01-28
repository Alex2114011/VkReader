//
//  WallService.swift
//  VkReader
//
//  Created by Alex on 24.11.2020.
//

import Foundation

///сначала создается протокол в котором определяем что должен содержать или выполнить класс это нужно для того чтобы не привязываться к определенному объекту, мы можем указывать протокол как тип данных который содержит нужные методы и свойтва
protocol WallService {
    func getPosts(for ownerID:Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<WallDTO>) -> Void))
    var ownerID:Int {get set}
}

class WallServiceImpl: WallService{
    var ownerID: Int = 0
    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider
    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }
/// в методе указавываем параметры запроса к апи, эти параметры передаем в baseNetworkService
    func getPosts(for ownerID:Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<WallDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["count" : "\(count)", "offset": "\(offset)", "owner_id": "-\(ownerID)", "access_token": token, "v": "5.126", "extended": "1"]
        baseNetworkService.sendRequest(url: urlProvider.wallGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)


    }
}
