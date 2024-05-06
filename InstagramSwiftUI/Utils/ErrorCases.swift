//
//  ErrorCases.swift
//  InstagramSwiftUI
//
//  Created by kashee on 31/03/24.
//

import Foundation



enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid url found"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}
