//
//  URLProvider.swift
//  VkReader
//
//  Created by Alex on 24.11.2020.
//

import Foundation
/// протокол предоставляет метод апи, нужно это для того чтобы можно в было в будущем расширить такие методы
protocol URLProvider {
    var wallGet:URL {get}
    var commentsGet:URL {get}
    var accountGetProfileInfo: URL {get}
    var groupsGet: URL {get}
    var groupsGetCatalog: URL {get}
    var groupsInfoGet: URL {get}
}

/// реализация требований протокола в которой переменной присваивается метод апи
class URLProviderImpl: URLProvider {
    
    var accountGetProfileInfo: URL {
        return URL(string: "account.getProfileInfo")!
    }
    
    var groupsGet: URL {
        return URL(string: "groups.get")!
    }
    
    var groupsGetCatalog: URL {
        return URL(string: "groups.getCatalog")!
    }
    
    var groupsInfoGet: URL {
        return URL(string: "groups.getById")!
    }
    
    var wallGet: URL {
        return URL(string: "wall.get")!
    }
    var commentsGet: URL {
        return URL(string: "wall.getComments")!
    }
}
