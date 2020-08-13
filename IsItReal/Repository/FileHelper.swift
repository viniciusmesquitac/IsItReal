//  FileHelper.swift
//  FoundPersBas
//
//  Created by Yuri on 04/04/19.
//  Copyright © 2019 academy.IFCE. All rights reserved.
//
import Foundation

//MARK: - FileManager
struct FileHelper {
    
    let manager = FileManager.default
    let mainPath  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //Create a new directory on the documents by default, or on the choosen path
    func createDirectory(with name: String, at path: String? = nil) {
        let contentPath = constructPath(named: name, from: path)
        if !directoryExists(with: name, at: path) {
            do {
                try manager.createDirectory(at: contentPath, withIntermediateDirectories: true, attributes: nil)
            } catch (let error) { print(error.localizedDescription) }
        }
    }
    
    //Remove directory and all of it's contents
    func removeDirectory(named: String, at path: String? = nil) -> Bool {
        let dirPath = constructPath(named: named, from: path)
        do {
            try manager.removeItem(at: dirPath)
            return !manager.fileExists(atPath: dirPath.path)
        } catch (let error) {
            print(error.localizedDescription)
            return false
        }
    }
    
    //Check if the directory exists
    func directoryExists(with name: String, at path: String? = nil) -> Bool {
        let dirPath = constructPath(named: name, from: path)
        var isDirectory = ObjCBool(true)
        return manager.fileExists(atPath: dirPath.path, isDirectory: &isDirectory) && isDirectory.boolValue
        
    }
    
    func contentsForDirectory(atPath path: String) -> [String] {
        let contentPath = constructPath(named: path)
        let itens = try? manager.contentsOfDirectory(atPath: contentPath.path)
        return itens ?? []
    }
    
    func fullPathForContents(at directory: String) -> [String] {
        let contentPath = constructPath(named: directory)
        guard let itens = try? manager.contentsOfDirectory(atPath: contentPath.path) else {
            return []
        }
        
        return itens.map { "\(contentPath.path)/\($0)"}
    }
    
    @discardableResult
    func createFile(with data: Data, name: String) -> Bool {
        let contentPath = constructPath(named: name)
        manager.createFile(atPath: contentPath.path, contents: data, attributes: nil)
        return manager.fileExists(atPath: contentPath.path)
    }
    
    @discardableResult
    func removeFile(at path: String) -> Bool {
        let contentPath = constructPath(named: path)
        do {
            try manager.removeItem(at: contentPath)
            return !manager.fileExists(atPath: contentPath.path)
        } catch (let error) {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    func updateFile(at path: String, data: Data) -> Bool {
        let contentPath = constructPath(named: path)
        do {
            try data.write(to: contentPath)
            return true
        } catch (let error) {
            print(error.localizedDescription)
            return false
        }
    }
    
    func retrieveFile(at path: String) -> Data? {
        let contentPath = constructPath(named: path)
        let data = try? Data(contentsOf: contentPath)
        return data
    }
    
    func constructPath(named: String, from path: String? = nil) -> URL {
        let contentPath = mainPath
        
        print("MainPath: \(contentPath.absoluteString) \n CompletePath = + \(path ?? "nil")")
        if let path = path {
            return contentPath.appendingPathComponent(path).appendingPathComponent(named)
        } else {
            return contentPath.appendingPathComponent(named)
        }
    }
}
