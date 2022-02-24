//
//  HomeView.swift
//  CryptoCurrency
//
//  Created by Mohammed Alsaleh on 23/07/1443 AH.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var VM : ViewModel
    @State var SearchTF = ""
    @Binding var FavoriteCoins : Data
    var body: some View {
        NavigationView {
            List(self.VM.CoinsArray.filter { $0.name!.contains(SearchTF) || SearchTF.isEmpty } , id: \.self.id) { data in
                HStack {
                    KFImage(URL(string: data.image!)!)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(data.name!)
                    Spacer()
                    Text(data.currentPrice!.description)
                        .padding(.horizontal , 5)
                        .background(RoundedRectangle(cornerRadius: 5).stroke())
                }.swipeActions(edge: .trailing) {
                    Button {
                        if self.FavoriteCoins == (try! JSONSerialization.data(withJSONObject: [], options: [])) {
                            // if don't have any Favorite Coins
                            self.FavoriteCoins = try! JSONSerialization.data(withJSONObject: [data.id!].uniqued(), options: [])
                        } else {
                            // if have a Favorite Coins
                           var array = (try! JSONSerialization.jsonObject(with: self.FavoriteCoins, options: [])) as! [String]
                            array.append(data.id!)
                            self.FavoriteCoins = try! JSONSerialization.data(withJSONObject: array.uniqued(), options: [])
                        }
                        
                    } label: {
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                    }.tint(.orange)
                }
            }.navigationBarTitle("Coins").refreshable(action: {
                self.VM.CoinsArray.removeAll()
                self.VM.GetCoins()
            })
        }.searchable(text: $SearchTF)
    }
}
