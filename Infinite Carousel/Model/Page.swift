//
//  Page.swift
//  Infinite Carousel
//
//  Created by Silvio Colmán on 2023-04-01.
//

import SwiftUI

/// Page Model
struct Page: Identifiable, Hashable {
    var id: UUID = .init()
    var color: Color
}
