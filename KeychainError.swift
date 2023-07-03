//
//  KeychainError.swift
//  
//
//  Created by devxsby on 2023/07/03.
//

import Foundation

@frozen
enum KeychainError: Error {
    case dataConversionFailed
    case saveFailed(OSStatus)
    case loadFailed(OSStatus)
}
