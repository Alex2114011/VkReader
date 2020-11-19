//
//  WebCacheCleaner.swift
//  VkReader
//
//  Created by p.grechikhin on 17.11.2020.
//

import Foundation
import WebKit
/// Этот класс отвечает за очистку WebView от кэша
class WebCacheCleaner {
    
    static func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
}
