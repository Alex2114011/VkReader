//
//  BaseNetworkService.swift
//  VkReader
//
//  Created by p.grechikhin on 16.11.2020.
//

import Foundation

protocol BaseNetworkService {
    func sendRequest<T: Decodable>(url: URL, parameters: [String: String], httpMethod: HTTPMethod, headerParameters: [String: String]?, data: Data?, callback: @escaping ((LoadingResult<T>) -> Void))
}
///Класс отвечает за работу с сетью, он отправляет запросы в сеть и если их получил то сохраняет данные в case gthечисления loadingResult success
class BaseNetworkServiceImpl: BaseNetworkService {
    
    let hostProvider: HostProvider
    
    init(hostProvider: HostProvider) {
        self.hostProvider = hostProvider
    }
    
    /// Дженерик который позволяет на его основе делать запрос в сеть
    /// - Parameters:
    ///   - url: Принимает значение Url адреса
    ///   - parameters: словарь с параметрами которые передаются в запросе
    ///   - httpMethod: Принимает тип метода из перечисления
    ///   - headerParameters: параметры которые должны передаваться в заголовке
    ///   - data: запрос данных в json
    ///   - callback: Замыкание которое сохраняет полученные данные
    func sendRequest<T>(url: URL,
                        parameters: [String: String],
                        httpMethod: HTTPMethod,
                        headerParameters: [String:String]?,
                        data: Data?,
                        callback: @escaping ((LoadingResult<T>) -> Void)) where T : Decodable {
        
        let urlWithHost = hostProvider.getHostURL().appendingPathComponent(url.absoluteString)
        guard var components = URLComponents(url: urlWithHost, resolvingAgainstBaseURL: true) else { return }
        components.queryItems = parameters.map({ URLQueryItem(name: $0, value: $1) })
        guard let finalURL = components.url else { return }
        var request = URLRequest(url: finalURL)
        if let headerParams = headerParameters {
            for (key, value) in headerParams {
                request.addValue(key, forHTTPHeaderField: value)
            }
        }
        request.httpMethod = httpMethod.rawValue.uppercased()
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    callback(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    callback(.failure(nil))
                }
                return
            }
            
            let rawJson = try? JSONSerialization.jsonObject( with: data, options: [])
            
            guard let jsonModel = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    callback(.failure(nil))
                }
                return
            }
            
            DispatchQueue.main.async {
                callback(.success(jsonModel))
                
            }
        }.resume()
        
    }
}
