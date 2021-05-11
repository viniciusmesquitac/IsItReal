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
    private var tweetText: String?
    private let minNumberOfWords = 3
    private let maxNumberOfWords = 40
    
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
    
    func createQuery(text: String, completion: @escaping (TweetQuery) -> Void) throws {
        
        guard let screenName = extractScreenName(from: text) else { throw ImageReaderError.impossibleFindUserScreen }
        
        if let text = tweetText {
            tweetText = removeCommonWords(from: text)
        }
        
        let keySearch = tweetText?.split(separator: " ")
        guard var splitedTweetText = keySearch else { throw ImageReaderError.impossibleToFindTheText }
       
        if splitedTweetText.count == 0 {
            let newTweetText = self.removeCommonWords(from: text)
            splitedTweetText = newTweetText.split(separator: " ")
        }
        
        if splitedTweetText.count < minNumberOfWords || splitedTweetText.count > maxNumberOfWords {
            throw ImageReaderError.impossibleToRead
        }
        
        APITwitter.shared.getUser(screenName: screenName) { myUser in
            splitedTweetText = self.removeUsername(from: splitedTweetText, userName: myUser!.name)
            
            var textToSearch = ""
            for index in 0..<splitedTweetText.count - self.minNumberOfWords {
                textToSearch.append("\(splitedTweetText[index]) ")
            }
            
            textToSearch.append(screenName)
            completion(TweetQuery(textTweet: self.tweetText, query: textToSearch, user: screenName, keySearch: splitedTweetText))
        }
    }
    
    private func removeUsername(from text: [String.SubSequence], userName: String) -> [String.SubSequence] {
        var result = text
        if let index = result.firstIndex(of: String.SubSequence(userName)) {
            result.remove(at: index)
        }
        return result
    }
    
    private func removeCommonWords(from text: String) -> String {
        let commomWords = [
            "Translate Tweet", "Tweetbot for Mac", "Twitter for iPad",
            "Retweet and comment", ":", "Tweetbot for IOS"
        ]
        
        let result = remove(words: commomWords, from: text)
        return result ?? ""
    }
    
    private func extractScreenName(from text: String) -> String? {
        var user: String?
        
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
            }
            else {
                if let allTextindex = text.index(of: "Twitter") {
                    tweetText = String(text[..<allTextindex])
                }
                if let userNameindex = text.index(of: user!) {
                    tweetText = String(text[..<userNameindex])
                }
            }
        }
        return user
    }
    
    private func remove(words: [String], from text: String) -> String? {
        var result: String?
        for word in words {
            if let index = text.index(of: word) {
                result = String(text[..<index])
            }
        }
        return result
    }
    
    private func splitGetFirst(_ text: String?) -> String {
        let splited = text?.split(separator: " ")
        return String(splited!.first!)
    }
    
    public func getUrlFromImage(forImageNamed name: String) -> URL? {
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
