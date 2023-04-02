//
//  ContentView.swift
//  Infinite Carousel
//
//  Created by Silvio Colmán on 2023-04-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Infinite Corousel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
