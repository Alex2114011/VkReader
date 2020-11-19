//
//  CredentialsStorage.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import Foundation
import Security
/// В этом классе реализуются методы работы с Keychain так как есть требование хранить авторизационные данные пользователей в зашифрованном виде
class CredentialsStorage {
    ///Создается константа Data в нее мы кладем значение пароля. в kSecAttrAccount мы кладем название элемента
    /// в этом методе при сохранении мы сначала очищаем хранилище, а затем сохраняем новое значение об этом нам говорит  SecItemDelete(query as CFDictionary)
    func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    /// Метод отвечающий за получение зашифрованного пароля по ключу, SecItemCopyMatching возвращает нам значение
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
    /// очищаем все хранилище ключей
    func remove(by key: String) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key]
        SecItemDelete(query as CFDictionary)
    }
    
}
