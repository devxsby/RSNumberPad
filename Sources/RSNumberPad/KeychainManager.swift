//
//  KeychainManager.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import Foundation
import Security

final class KeychainManager {
    
    class func save(key: String, data: String) -> Result<Void, KeychainError> {
        guard let data = data.data(using: .utf8) else {
            return .failure(.dataConversionFailed)
        }
        
        let query = buildQuery(for: key, data: data)
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == noErr {
            return .success(())
        } else {
            return .failure(.saveFailed(status))
        }
    }
    
    class func load(key: String) -> Result<String, KeychainError> {
        let query = buildQuery(for: key, returnData: kCFBooleanTrue, matchLimit: kSecMatchLimitOne)
        
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr,
           let data = dataTypeRef as? Data,
           let password = String(data: data, encoding: .utf8) {
            return .success(password)
        } else {
            return .failure(.loadFailed(status))
        }
    }
    
    private class func buildQuery(for key: String,
                                  data: Data? = nil,
                                  returnData: Any? = nil,
                                  matchLimit: Any? = nil) -> [String: Any] {
        var query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as [String: Any]
        
        if let data = data {
            query[kSecValueData as String] = data
        }
        
        if let returnData = returnData {
            query[kSecReturnData as String] = returnData
        }
        
        if let matchLimit = matchLimit {
            query[kSecMatchLimit as String] = matchLimit
        }
        
        return query
    }
}
