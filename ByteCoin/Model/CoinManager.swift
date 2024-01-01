//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinDelegate {
    func getRate(_ rate:String)
}

struct CoinManager {
    var delegate:CoinDelegate!
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey =  "839DF104-0AA7-43E8-8D74-3F924F6C5B56"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let cryptoArray = ["Bitcoin","Ethereum","Tether","BNB","XRP","USD Coin","Solana","Cardano","Dogecoin","Tron","Toncoin","Chainlink"]
    let cryptocurrencies = [
        "Bitcoin":"BTC","Ethereum":"ETH","Tether":"USDT","BNB":"BNB","XRP":"XRP","USD Coin":"USDC",
        "Solana":"SOL","Cardano":"ADA","Dogecoin":"DOGE","Tron":"TRX","Toncoin":"TON","Chainlink":"LINK"
    ]

    func getCoinPrice(for currency:String,crypto:String) {
       performRequest(baseURL+"\(crypto)/\(currency)?apikey=\(apiKey)")
        
    }
    func performRequest(_ urlString:String) {
        print(urlString)
        let url = URL(string:urlString)!
        let urlSession = URLSession(configuration: .default)
       let task =  urlSession.dataTask(with: url) {(data,response,error) in
            //print(String(data: data!, encoding: .utf8)!)
         let rate = jasonFormat(data: data!)
           delegate.getRate(rate)
            
        }
        task.resume()
        
    }
    func jasonFormat(data:Data)->String {
        let model = try! JSONDecoder().decode(RateModel.self, from: data)
       // print(model.rate)
        return String(format: "%.2f", model.rate)
    }
}
