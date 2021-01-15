//
//  AccountService.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import Foundation

///сначала создается протокол в котором определяем что должен содержать или выполнить класс это нужно для того чтобы не привязываться к определенному объекту, мы можем указывать протокол как тип данных который содержит нужные методы и свойтва
protocol AccountService {
    func getAccount(callback: @escaping ((LoadingResult<AccountDTO>) -> Void))
}

class AccountServiceImpl: AccountService{

    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider
    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }
/// в методе указавываем параметры запроса к апи, эти параметры передаем в baseNetworkService
    func getAccount(callback: @escaping ((LoadingResult<AccountDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["access_token": token, "v": "5.126"]
        baseNetworkService.sendRequest(url: urlProvider.accountGetProfileInfo, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)


    }
}
