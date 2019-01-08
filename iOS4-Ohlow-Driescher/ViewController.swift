//
//  ViewController.swift
//  iOS4-Ohlow-Driescher
//
//  Created by Jan Driescher on 03.12.18.
//  Copyright © 2018 Jan Driescher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        euroToDollar.text = String(ExchangeRates.euroToDollar).replacingOccurrences(of: ".", with: ",")
        euroToPound.text =  String(ExchangeRates.euroToPound).replacingOccurrences(of: ".", with: ",")
        poundToDollar.text =  String(ExchangeRates.poundToDollar).replacingOccurrences(of: ".", with: ",")
        self.pound.delegate = self
        self.dollar.delegate = self
        self.euro.delegate = self
        euro.keyboardType = UIKeyboardType.numbersAndPunctuation
        dollar.keyboardType = UIKeyboardType.numbersAndPunctuation
        pound.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    @IBAction func changedEuro(_ sender: Any) {
       changeEuro()
    }
    @IBAction func changedDollar(_ sender: Any) {
        changeDollar()
    }
    @IBAction func changedPound(_ sender: Any) {
        changePound()
    }
    
    func changeEuro(){
        if let val = euro.text?.replacingOccurrences(of: ",", with: ".") {
            if let doubleVal = Double(val){
                euro.text = ExchangeRates.convert(toOutput: doubleVal)
                dollar.text = ExchangeRates.convert(toOutput: (doubleVal * ExchangeRates.euroToDollar))
                pound.text = ExchangeRates.convert(toOutput: (doubleVal * ExchangeRates.euroToPound))
                
            }
        }
    }
    
    
    func changeDollar(){
        if let val = dollar.text?.replacingOccurrences(of: ",", with: ".")  {
            if let doubleVal = Double(val){
                euro.text = ExchangeRates.convert(toOutput: doubleVal / ExchangeRates.euroToDollar)
                dollar.text = ExchangeRates.convert(toOutput: doubleVal)
                pound.text =  ExchangeRates.convert(toOutput: doubleVal * ExchangeRates.poundToDollar)
            }
        }
    }
    
    func changePound(){
        if let val = pound.text?.replacingOccurrences(of: ",", with: ".") {
            if let doubleVal = Double(val){
                euro.text =  ExchangeRates.convert(toOutput: doubleVal / ExchangeRates.euroToPound)
                dollar.text =  ExchangeRates.convert(toOutput: doubleVal / ExchangeRates.poundToDollar)
                pound.text = ExchangeRates.convert(toOutput: doubleVal)
            }
        }
    }
    
    
    @IBAction func fetchExchangeRates(_ sender: Any) {
        ExchangeRates.updateRates()
        print(ExchangeRates.euroToDollar)
        print(ExchangeRates.euroToPound)
        print(ExchangeRates.poundToDollar)
        if(ExchangeRates.hasFetched == false){
            let alert = UIAlertController(title: "Failed to fetch Data", message: "You need a working internet connection to fetch data from finanzen.net. Default values from November 20th 2018 have been applied.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        euroToDollar.text = String(ExchangeRates.euroToDollar).replacingOccurrences(of: ".", with: ",")
        euroToPound.text =  String(ExchangeRates.euroToPound).replacingOccurrences(of: ".", with: ",")
        poundToDollar.text =  String(ExchangeRates.poundToDollar).replacingOccurrences(of: ".", with: ",")
        changeEuro()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBOutlet weak var euroToDollar: UILabel!
    @IBOutlet weak var euroToPound: UILabel!
    @IBOutlet weak var euro: UITextField!
    @IBOutlet weak var poundToDollar: UILabel!
    @IBOutlet weak var dollar: UITextField!
    @IBOutlet weak var pound: UITextField!
    
}

