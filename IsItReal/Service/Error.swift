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
}

extension ImageReaderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .impossibleToRead:
            return NSLocalizedString("Impossible to read this image", comment: "Impossible to read error")
        }
    }
}

enum AnalyseError: Error {
    case notImage
}

extension AnalyseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notImage:
            return NSLocalizedString("Select an image to analyse", comment: "Not image")
        }
    }
}
