//
//  Item.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
