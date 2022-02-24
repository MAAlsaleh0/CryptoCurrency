//
//  FavoriteView .swift
//  CryptoCurrency
//
//  Created by Mohammed Alsaleh on 23/07/1443 AH.
//

import SwiftUI
import Kingfisher

struct FavoriteView: View {
    @StateObject var VM : ViewModel
    @Binding var FavoriteCoins : Data
    @State var SearchTF = ""
    var body: some View {
        NavigationView {
            if FavoriteCoins == (try! JSONSerialization.data(withJSONObject: [], options: [])) {
                Text("You don't add any Coin!!")
            } else {
                List {
                    ForEach(self.VM.CoinsArray.filter { $0.name!.contains(SearchTF) || SearchTF.isEmpty } , id: \.self.id) { data in
                        if ((try! JSONSerialization.jsonObject(with: FavoriteCoins, options: [])) as! [String]).contains(data.id!) {
                            HStack {
                                KFImage(URL(string: data.image!)!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text(data.name!)
                                Spacer()
                                Text(data.currentPrice!.description)
                                    .padding(.horizontal , 5)
                                    .background(RoundedRectangle(cornerRadius: 5).stroke())
                            }
                        }
                        
                    }.onDelete { index in
                        var a = (try! JSONSerialization.jsonObject(with: FavoriteCoins, options: [])) as! [String]
                        a.remove(atOffsets: index)
                        self.FavoriteCoins = try! JSONSerialization.data(withJSONObject: a, options: [])
                    }
                }.refreshable {
                    self.VM.CoinsArray.removeAll()
                    self.VM.GetCoins()
                }.searchable(text: $SearchTF).navigationBarTitle("My Coins")
            }
        }
    }
}
