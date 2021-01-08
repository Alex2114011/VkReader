//
//  CommentsService.swift
//  VkReader
//
//  Created by  Alex on 17.12.2020.
//

import Foundation

protocol CommentsService {
    func getComments(for postIdentifier: Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<CommentDTO>) -> Void))
    var postID: Int {get set}
}

class CommentsServiceImpl: CommentsService{
    var postID:Int = 0 
    let sort = "desc"
    
    fileprivate let ownerID: String = "-20845272" // группа с длинными постами -83978073 и с маленькими  -65662695 -146780172"  -20845272
    ///указываем свойства необходимые для отправки запроса
    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider

    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }

    
    func getComments(for postIdentifier: Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<CommentDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["count" : "\(count)", "offset": "\(offset)", "owner_id": "\(ownerID)", "access_token": token, "post_id":"\(postIdentifier)","need_likes":"1" ,"thread_items_count":"2", "sort":sort, "v": "5.126", "extended": "1"]
        baseNetworkService.sendRequest(url: urlProvider.commentsGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
    }
}

//"comment_id":"859783",
