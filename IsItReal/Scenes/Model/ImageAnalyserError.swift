//
//  ImageAnalyserError.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 04/09/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

enum ImageAnalyserError: Error {
    case notImage
    case notFound
    case notValid
}

extension ImageAnalyserError: LocalizedError {
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
