//
//  Item.swift
//  Mind's Eye
//
//  Created by BASHAER AZIZ on 16/06/1446 AH.
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
