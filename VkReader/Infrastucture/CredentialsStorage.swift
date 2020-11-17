//
//  CredentialsStorage.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import Foundation
import Security

class CredentialsStorage {
    
    func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func get(key: String) -> String? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            guard let data = dataTypeRef as! Data? else { return nil }
            return String(decoding: data, as: UTF8.self)
        } else {
            return nil
        }
    }
    
    func remove(by key: String) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key]
        SecItemDelete(query as CFDictionary)
    }
    
}
