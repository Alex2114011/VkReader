//
//  CommentsThreadService.swif
//  VkReader
//
//  Created by Alex on 05.01.2021.
//

import Foundation

protocol CommentsThreadService {
    func getThreadComments(for postIdentifier: Int, with commentID: Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<CommentDTO>) -> Void))
    var postID: Int {get set}
}

class CommentsThreadServiceImpl: CommentsThreadService{
    var postID:Int = 0
    let sort = ""
    
    fileprivate let ownerID: String = "-65662695" // группа с длинными постами -83978073 и с маленькими  -65662695
    ///указываем свойства необходимые для отправки запроса
    let credentials: CredentialsStorage
    let baseNetworkService: BaseNetworkService
    let urlProvider: URLProvider

    
    init(credentials: CredentialsStorage, baseNetworkService: BaseNetworkService, urlProvider: URLProvider) {
        self.credentials = credentials
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
    }

    
    func getThreadComments(for postIdentifier: Int, with commentID: Int, count: Int, with offset: Int, callback: @escaping ((LoadingResult<CommentDTO>) -> Void)) {
        guard let token = credentials.get(key: kToken) else { callback(.failure(nil)); return }
        let parameters = ["count" : "\(count)", "offset": "\(offset)", "owner_id": "\(ownerID)", "access_token": token, "post_id":"\(postIdentifier)","need_likes":"1",  "thread_items_count":"10", "sort":sort, "comment_id":"\(commentID)", "v": "5.126", "extended": "1"]
        baseNetworkService.sendRequest(url: urlProvider.commentsGet, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil, callback: callback)
    }
}
