//
//  FarmersMarketAPIClient.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation

class FarmersMarketAPIClient {
    private init() {}
    static var manager = FarmersMarketAPIClient()
    //this function will load all the FarmersMarket from the API
    func getMarkets(completion: @escaping ([FarmersMarket])->Void, errorHandler:@escaping (Error)->Void){
        let urlStr = "https://data.cityofnewyork.us/resource/cw3p-q2v6.json"
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let markets = try JSONDecoder().decode([FarmersMarket].self, from: data)
                completion(markets)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}


