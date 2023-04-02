//
//  Home.swift
//  
//
//  Created by Silvio Colmán on 2023-04-01.
//

import SwiftUI

struct Home: View {
    /// View Proterties
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    /// Propiedades de carrusel infinito.
    /// Contiene la primera y la última página duplicada por delante y por detrás para crear un carrusel infinito.
    @State private var fakedPages: [Page] = []
    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $currentPage, content: {
                ForEach(fakedPages) { Page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(Page.id.uuidString)
                        /// Cálculo del desplazamiento completo de la página
                        .offsetX(currentPage == Page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(Page)))
                            /// Convertir desplazamiento de página en progreso
                            let pageProgress = pageOffset / size.width
                            /// Lógica de carrusel infinito
                            if -pageProgress < 1 {
                                /// Ir a la última página
                                /// ¿Cuál es en realidad la primera página duplicada?
                                /// Comprobación segura
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                /// Ir a la última página
                                /// ¿Cuál es en realidad la última página duplicada?
                                /// Comprobación segura
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPage: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        /// Creación de algunas pestañas de muestra
        .onAppear {
            guard fakedPages.isEmpty else { return }
            for color in [Color.red, Color.green, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(.init(color: color))
            }
            
            fakedPages.append(contentsOf: listOfPages)
            
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                
                currentPage = firstPage.id.uuidString
                
                /// Actualizando id
                firstPage.id = .init()
                lastPage.id = .init()
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }
    
    func fakeIndex(_ of: Page) -> Int {
        return fakedPages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
