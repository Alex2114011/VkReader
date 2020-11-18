//
//  URLProvider.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import Foundation

protocol URLProvider {
    var wallGet: URL { get }
}

class URLProviderImpl: URLProvider {
    var wallGet: URL {
        return URL(string: "wall.get")!
    }
}
