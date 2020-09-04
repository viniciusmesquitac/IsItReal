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
    
    // Very Complex :/
    func createQuery(text: String, completion: @escaping (QueryResult) -> Void) throws {
        var user: String?
        var tweetText: String?
        
        // get user
        if let userIndex = text.lastIndex(of: "@") {
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
        
        if let text = tweetText {
            tweetText = removeCommonWords(from: text)
        }
        
        let keySearch = tweetText?.split(separator: " ")
        
        guard let screenName = user else { throw ImageReaderError.impossibleFindUserScreen }
        guard var mtweetText = keySearch else { throw ImageReaderError.impossibleToFindTheText }
        
        // if count == 1 return to all text
        if mtweetText.count == 0 {
            let newText = self.removeCommonWords(from: text)
            mtweetText = newText.split(separator: " ")
        }
        
        if mtweetText.count < 3 {
            throw ImageReaderError.impossibleToRead
        }
        
        // async
        APITwitter.shared.getUser(screenName: screenName) { myUser in
            mtweetText = self.removeUsername(from: mtweetText, userName: myUser!.name)
            
            var completed = ""
            for index in 0..<mtweetText.count - 3 {
                completed.append("\(mtweetText[index]) ")
            }
            
            completed.append("\(screenName)")
            completion(QueryResult(textTweet: tweetText, query: completed, user: screenName, keySearch: mtweetText))
        }

    }
    
    func removeUsername(from text: [String.SubSequence], userName: String) -> [String.SubSequence] {
        var result = text
        if let index = result.firstIndex(of: String.SubSequence(userName)) {
            result.remove(at: index)
        }
        return result
    }
    
    func removeCommonWords(from text: String) -> String {
        
        var result = text
        
        if let allTextindex = text.index(of: "Twitter") {
            result = String(text[..<allTextindex])
        }
        
        if let index = result.index(of: "Translate Tweet") {
             result = String(text[..<index])
        }
        
        if let index = result.index(of: "Tradução") {
            result = String(text[..<index])
        }
        
        if let index = result.index(of: "Tweetbot for Mac") {
            result = String(text[..<index])
        }
        
        if let index = result.index(of: "Twitter for iPad") {
            result = String(text[..<index])
        }
        
        if let index = result.index(of: "Retweet and comment") {
            result = String(text[..<index])
        }
        
        if let index = result.index(of: ":") {
            result = String(text[..<index])
        }
        return result
    }
    
    func splitGetFirst(_ text: String?) -> String {
          let splited = text?.split(separator: " ")
          return String(splited!.first!)
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
}
