//
//  APIData.swift
//  ByteCoin
//
//  Created by Mohamed Reyad on 10/7/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

//MARK:- Show Result Delegate Protocol
protocol ShowResultsDelegate {
    func showResults(_ decodedData : Double)
}

//MARK:- CoinManager Struct Declaration

import Foundation
import UIKit

struct CoinManager {
    var currency : String = ""
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6A86810A-59A7-478D-A6AE-23589F9095AE"
    let currencyArray : [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate : ShowResultsDelegate?
    
    func fetchData(){
        let urlAddedCurrency = baseURL + "/\(currency)"
        let urlReady = urlAddedCurrency + "?apikey=\(apiKey)"
        print(urlReady)
        let url = URL(string: urlReady)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!, completionHandler: {(data, response,error ) in
            if error != nil{
                print(error!)
                return
            }
            if let safeData = data{
                self.decodeData(safeData)
                
            }})
        task.resume()
    }
    
    func decodeData(_ data : Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try (decoder.decode(APIData.self, from: data))
            print(decodedData.rate)
            self.delegate?.showResults(decodedData.rate)
        } catch {
            print(error)
        }
    }
    
}
