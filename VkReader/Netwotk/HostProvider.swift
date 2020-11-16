//
//  HostProvider.swift
//  VkReader
//
//  Created by p.grechikhin on 16.11.2020.
//

import Foundation

protocol HostProvider {
    var host: HostProviderImpl.Host { get set }
    func getHostURL() -> URL
}

class HostProviderImpl: HostProvider {
    enum Host {
        case prod
    }
    
    var host: Host = .prod
    
    func getHostURL() -> URL {
        switch host {
        case .prod:
            return URL(string: "https://api.vk.com/method/")!
        }
    }
}
