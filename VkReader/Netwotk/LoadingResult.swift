//
//  LoadingResult.swift
//  VkReader
//
//  Created by p.grechikhin on 16.11.2020.
//

import Foundation

enum LoadingResult<T> {
    case success(T)
    case failure(Error?)
}
