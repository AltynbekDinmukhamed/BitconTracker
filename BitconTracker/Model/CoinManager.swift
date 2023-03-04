//
//  CoinManager.swift
//  BitconTracker
//
//  Created by Димаш Алтынбек on 03.03.2023.
//

import Foundation

protocol CoinManagerProtocol {
    func didUpdatePrice(price: String, currnecy: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerProtocol?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "F57F21A1-D029-4571-8C3D-5B5D353462A5"
        
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = self.parseJson(safeData) {
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currnecy: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            print (error)
            return nil
        }
    }
    
}
