//
//  Error.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 19/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

enum ImageReaderError: Error {
    case impossibleToRead
    case impossibleFindUserScreen
    case impossibleToFindTheText
}

extension ImageReaderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .impossibleToRead:
            return NSLocalizedString("Impossible to read this image, chose another image.", comment: "Impossible to read error")
        case .impossibleFindUserScreen:
            return NSLocalizedString("Impossbile to extract user from image, Check users with verified icon", comment: "Impossible to read error")
        case .impossibleToFindTheText:
            return NSLocalizedString("Impossibile extract text from image, Avoid unnecessary information in prints (date/comments/image)", comment: "Impossible to read error")
        }
    }
}
