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
            return NSLocalizedString("Impossbile to find screename from user, try to find users with verified icon", comment: "Impossible to read error")
        case .impossibleToFindTheText:
            return NSLocalizedString("Impossbile to find tweetText, find a better position to read this tweet", comment: "Impossible to read error")
        }
    }
}

enum AnalyseError: Error {
    case notImage
    case notFound
    case notValid
}

extension AnalyseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notImage:
            return NSLocalizedString("You dont select any image, Select an image to start analyse!", comment: "Not image")
        case .notFound:
            return NSLocalizedString("We dont be able to find this in Tweet, try an image with better resolution!", comment: "Not image")
        case .notValid:
            return NSLocalizedString("This image is not valid, select print from twitter", comment: "Not image")
        }
    }
}
