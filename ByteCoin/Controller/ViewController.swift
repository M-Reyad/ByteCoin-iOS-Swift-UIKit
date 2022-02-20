//
//  APIData.swift
//  ByteCoin
//
//  Created by Mohamed Reyad on 10/7/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var exchangeRate: UILabel!
    @IBOutlet weak var exchangeCurrency: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var coinData = CoinManager()
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        coinData.delegate = self
    }
}
//MARK: - PickerView Delegate

extension ViewController : UIPickerViewDelegate{
}
//MARK: - PickerView Data Source

extension ViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinData.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
        coinData.currency = exchangeCurrency.text!
        self.coinData.fetchData()
        print(coinData.currency)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (coinData.currencyArray[row])
    }
}

//MARK:- Show Results Delegate
extension ViewController :ShowResultsDelegate{
    func showResults(_ decodedData: Double) {
        let exchangeRate = String(format:"%0.1f" , decodedData)
        print(exchangeRate)
        DispatchQueue.main.async{
            self.exchangeRate.text = exchangeRate
            self.exchangeCurrency.text = self.coinData.currencyArray[self.row]
        }
    }
}

