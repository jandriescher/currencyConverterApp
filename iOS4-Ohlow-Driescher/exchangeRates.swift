//
//  exchangeRates.swift
//  iOS4-Ohlow-Driescher
//
//  Created by Jan Driescher on 03.12.18.
//  Copyright © 2018 Jan Driescher. All rights reserved.
//

import Foundation
import UIKit

class ExchangeRates{
    
    static var euroToDollar = 0.0
    static var euroToPound = 0.0
    static var poundToDollar = 0.0
    
    static var hasFetched = false
    
    static var defaultEuroToDollar = 1.1449
    static var defaultEuroToPound = 0.8905
    static var defaultPoundToDollar = (1/1.1449) * 0.8905
    
    class func convert(toOutput number: Double) -> String {
        let temp = String(format: "%.2f", number).replacingOccurrences(of: ".", with: ",")
        return temp
    }
    
    class func updateRates(){
        
        //fetching euro -> dollar
        if let url = URL(string:"https://www.finanzen.net/waehrungsrechner/euro_us-dollar"){
            if let content = try?String(contentsOf: url, encoding: .utf8){
                if let indexRange = content.range(of: "id=\"currency-conversion-result\" value=\""){
                    let startIndex = indexRange.upperBound
                    let endIndex = content.index(startIndex, offsetBy: 6)
                    let val = content[startIndex..<endIndex]
                    euroToDollar = Double(val.replacingOccurrences(of: ",", with: ".")) ?? defaultEuroToDollar
                }
            }
            else{
                euroToDollar = defaultEuroToDollar
            }
        }
        //fetching euro -> pound
        if let url = URL(string:"https://www.finanzen.net/waehrungsrechner/euro_britische-pfund"){
            if let content = try?String(contentsOf: url, encoding: .utf8){
                if let indexRange = content.range(of: "id=\"currency-conversion-result\" value=\""){
                    let startIndex = indexRange.upperBound
                    let endIndex = content.index(startIndex, offsetBy: 6)
                    let val = content[startIndex..<endIndex]
                    euroToPound = Double(val.replacingOccurrences(of: ",", with: ".")) ?? defaultEuroToPound
                    hasFetched = true
                }
            }
            else{
                euroToPound = defaultEuroToPound
                hasFetched = false
                
            }
        }
        
        //fetching euro -> pound
        poundToDollar = (1/euroToDollar)*euroToPound
        
        
        
    }
}
