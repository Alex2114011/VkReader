//
//  LoadingResult.swift
//  VkReader
//
//  Created by p.grechikhin on 16.11.2020.
//

import Foundation
/// дженерик перечисления может содержать в своих ассоциативных параметрах разные типы данных, в success сохраняются данные полученные из basenetworkservice
enum LoadingResult<T> {
    case success(T)
    case failure(Error?)
}
