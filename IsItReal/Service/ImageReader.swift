//
//  ImageReader.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 14/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//
import UIKit
import Vision

class ImageReader {
    
    public var failureHandler: (Error) -> Void = { _ in }
    
    func perform(on url: URL?, recognitionLevel: VNRequestTextRecognitionLevel) throws -> String {
        var stringResult = ""
        guard let url = url else { return "" }
        
        let requestHandler = VNImageRequestHandler(url: url, options: [:])
        
        let request = VNRecognizeTextRequest  { (request, error) in
            if let error = error {
                self.failureHandler(error)
                print(error)
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            for currentObservation in observations {
                let topCandidate = currentObservation.topCandidates(1)
                if let recognizedText = topCandidate.first {
                    stringResult.append(" \(recognizedText.string)")
                }
            }
        }
        request.recognitionLevel = recognitionLevel
        try? requestHandler.perform([request])
        
        if stringResult.isEmpty {
            throw ImageReaderError.impossibleToRead
        }
        return stringResult
    }
    
    func createQuery(text: String) throws -> QueryResult {
        var user: String?
        var tweetText: String?
        if let userIndex = text.firstIndex(of: "@") {
            user = String(text[userIndex..<text.endIndex])
            user = splitGetFirst(user)
            user?.removeFirst()
            if user?.last == "." {
                user?.removeLast()
            }
            
            if let verifyMarkIndex = text.firstIndex(of: "•") {
                if verifyMarkIndex < userIndex {
                    tweetText = String(text[verifyMarkIndex..<userIndex])
                    tweetText?.removeFirst()
                }
            } else {
                if let allTextindex = text.index(of: "Twitter") {
                    tweetText = String(text[..<allTextindex])
                }
                if let userNameindex = text.index(of: user!) {
                    tweetText = String(text[..<userNameindex])
                }
            }
        }
        let keySearch = tweetText?.split(separator: " ")
        var result = QueryResult(textTweet: nil, query: nil, user: nil, keySearch: nil)
        
        guard let screenName = user else { throw ImageReaderError.impossibleFindUserScreen }
        guard var mtweetText = keySearch else { throw ImageReaderError.impossibleToFindTheText }
        
        if mtweetText.count == 0 {
            mtweetText = text.split(separator: " ")
        }
        
        if mtweetText.count >= 6 {
            let complete = "\(mtweetText[0]) \(mtweetText[1]) \(mtweetText[2]) \(mtweetText[3]) \(mtweetText[4]) \(mtweetText[5]) \(screenName)"
            result = QueryResult(textTweet: tweetText, query: complete, user: screenName, keySearch: mtweetText)
            return result
        }
        return result
    }
    
    func getUrlFromImage(forImageNamed name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path

        guard fileManager.fileExists(atPath: path) else {
            guard let image = UIImage(named: name), let data = image.pngData() else {
                return nil
            }
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return url
        }

        return url
    }
    
    func splitGetFirst(_ text: String?) -> String {
        let splited = text?.split(separator: " ")
        return String(splited!.first!)
    }
}
