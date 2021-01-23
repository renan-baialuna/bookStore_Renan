//
//  ErrorMessages.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 22/01/21.
//

import Foundation

enum errorMessage {
    case problemConnecting
    case problemInResponse
    case problemWithCode(code: Int)
    case problemTranslatingData
}
