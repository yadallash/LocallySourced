//
//  NetworkHelper.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)
    case notAnImage
    case codingError(rawError: Error)
    case badData
    case urlError(rawError: Error)
}
class NetworkHelper {
    private init() {
        // this will allow to cash the urls instead of calling it repetitively
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                // this will check if there is a request have done before or not
                let request = URLRequest(url: url)
                if let response = URLCache.shared.cachedResponse(for: request) {
                    completionHandler(response.data)
                    return
                }
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode != 401 else{
                    errorHandler(AppError.badStatusCode)
                    return
                }
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler(AppError.noInternetConnection)
                    }else{
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                
                completionHandler(data)
            }
            }.resume()
    }
}

