//
//  PageControl.swift
//  Infinite Carousel
//
//  Created by Silvio Colmán on 2023-04-01.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    /// Page Properties
    /// VISTA DEL INDICADOR DE PÁGINA PARA EL CARRUSEL INFINITO,
    /// A PARTIR DE AHORA, NO TENEMOS NINGÚN MÉTODO NATIVO
    /// PARA USAR EL CONTROL DE PÁGINA POR SEPARADO
    /// EN LUGAR DE FUSIONARLO DENTRO DE PAGETABVIEW.
    var totalPage: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPage
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        control.allowsContinuousInteraction = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPage
        uiView.currentPage = currentPage
    }
}

