//
//  FirstExampleNetworkRequest.swift
//  VkReader
//
//  Created by p.grechikhin on 11.11.2020.
//

import UIKit

class PostsModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    var body: String?
}

class FirstExampleNetworkRequest {
    
    func makeRequest() {
        URLSession
            .shared
            .dataTask(with: URLProvider.completeURL(with: "/posts")) { (data, response, error) in
                if error != nil {
                    print("\(error?.localizedDescription)")
                    return
                }
                
                guard let data = data else { print("NO DATA"); return }
                let json = try? JSONDecoder().decode([PostsModel].self, from: data)
                let jsonRaw = try? JSONSerialization.jsonObject(with: data, options: [])
                print(jsonRaw)
                print(json)
            }.resume()
    }
    
}

class URLProvider {
    
    static let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    static func completeURL(with path: String) -> URL {
        let url = URLProvider.baseURL.appendingPathComponent(path)
        return url
    }
}
