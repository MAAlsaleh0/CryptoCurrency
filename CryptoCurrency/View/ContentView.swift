//
//  ContentView.swift
//  CryptoCurrency
//
//  Created by Mohammed Alsaleh on 23/07/1443 AH.
//

import SwiftUI

struct ContentView: View {
    @StateObject var VM = ViewModel()
    @AppStorage("Favorite Coins") var FavoriteCoins:Data = (try! JSONSerialization.data(withJSONObject: [], options: []))
    var body: some View {
        TabView {
            HomeView(VM: VM, FavoriteCoins: $FavoriteCoins)
                .tabItem {
                    Label("Coins", systemImage:"house")
                }
            FavoriteView(VM: VM,FavoriteCoins: $FavoriteCoins)
                .tabItem {
                    Label("My Coins", systemImage: "heart")
                }
        }.onAppear {
            self.VM.GetCoins()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
