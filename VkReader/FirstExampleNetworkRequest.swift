////
////  FirstExampleNetworkRequest.swift
////  VkReader
////
////  Created by p.grechikhin on 11.11.2020.
////
//
//import UIKit
//
//class PostsModel: Decodable {
//    let userId: Int
//    let id: Int
//    let title: String
//    var body: String?
//}
//
//class FirstExampleNetworkRequest {
//    
//    func makeRequest() {
//        URLSession
//            .shared
//            .dataTask(with: URLProvider.completeURL(with: "/posts")) { (data, response, error) in
//                if error != nil {
//                    print("\(error?.localizedDescription)")
//                    return
//                }
//                
//                guard let data = data else { print("NO DATA"); return }
//                let json = try? JSONDecoder().decode([PostsModel].self, from: data)
//                let jsonRaw = try? JSONSerialization.jsonObject(with: data, options: [])
//                print(jsonRaw)
//                print(json)
//            }.resume()
//    }
//    func makePost() {
//        let userData = ["One": "Two", "Three": "Four"]
//        var request = URLRequest(url: URLProvider.completeURL(with: "/posts"))
//        print(request)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return  }
//        request.httpBody = httpBody
//        
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            guard let response = response, let data = data else {return}
//            print(response)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print(error)
//            }
//        } .resume()
//    }
//}
//
//
//
//
//class URLProvider {
//    
//    static let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
//    
//    static func completeURL(with path: String) -> URL {
//        let url = URLProvider.baseURL.appendingPathComponent(path)
//        return url
//    }
//}
