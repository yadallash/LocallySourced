//
//  FileManagerHelper.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation
struct DefaultStruct:Codable {
    let name: String
    let id: Int
}

import UIKit
class FileManagerHelper {
    private init() {}
    let savedDataPath = "savedData"
    static let manager = FileManagerHelper()
    private var savedModelArray = [DefaultStruct]() {
        didSet {
            print(savedModelArray)
            saveDefaultArray()
        }
    }
    //Saving Images To Disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func getImage(with urlStr: String) -> UIImage? {
        do {
            let imagePathName = urlStr.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    func addNew(_ model: DefaultStruct) {
        savedModelArray.append(model)
    }
    func retrieveSavedElements() -> [DefaultStruct] {
        return savedModelArray
    }
    private func saveDefaultArray() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(savedModelArray)
            let phoneURL = dataFilePath(withPathName: savedDataPath)
            try encodedData.write(to: phoneURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func loadSavedElements() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(withPathName: savedDataPath)
            let encodedData = try Data(contentsOf: phoneURL)
            let storedModelArray = try propertyListDecoder.decode([DefaultStruct].self, from: encodedData)
            savedModelArray = storedModelArray
        }
        catch {
            print(error.localizedDescription)
        }
    }
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    //Helper function for the dataFilePath method
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

