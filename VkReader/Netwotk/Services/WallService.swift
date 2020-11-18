//
//  WallService.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import Foundation

protocol WallService {
    func getPosts(count: Int, with offset: Int, callback: @escaping ((LoadingResult<WallDTO>) -> Void))
}

class WallServiceImpl: WallService {
    
    fileprivate let ownerID: String = "-65662695"
    
    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider
    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }
    
    func getPosts(count: Int, with offset: Int, callback: @escaping ((LoadingResult<WallDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["count" : "\(count)", "offset": "\(offset)", "owner_id": "\(ownerID)", "access_token": token, "v": "5.126", "extended": "1"]
        baseNetworkService.sendRequest(url: urlProvider.wallGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
    }
    
}
