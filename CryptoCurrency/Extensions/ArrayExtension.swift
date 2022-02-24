//
//  ArrayExtension.swift
//  CryptoCurrency
//
//  Created by Mohammed Alsaleh on 23/07/1443 AH.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
