//
//  ViewModel.swift
//  CryptoCurrency
//
//  Created by Mohammed Alsaleh on 23/07/1443 AH.
//

import Foundation
import Combine

class ViewModel : ObservableObject {
    @Published var CoinsArray = [Coins]()
    
    func GetCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=1h") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let Coins = try! JSONDecoder().decode(coins.self, from: data!)
            DispatchQueue.main.async {
                self.CoinsArray = Coins
            }
        }.resume()
    }
}
