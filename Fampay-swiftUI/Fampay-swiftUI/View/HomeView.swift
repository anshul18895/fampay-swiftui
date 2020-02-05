//
//  HomeView.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI
import Combine



struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View{
        VStack{
            ZStack{
                FPImage.titleLogo.image().resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 25, alignment: .center)
            }
            .frame(width: Screen.width, height: 44, alignment: .center)
            .background(Color.white)
            
            List{
                ForEach(viewModel.cards){ (card) in
                    self.containedView(designType: card.designType ?? .HC1, cardElement: card)
                        .background(Color(hex: "#F7F6F3"))
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                               Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                           })
            .onAppear(perform: { self.viewModel.apply(.onAppear) })
        }
    }
    
    func containedView(designType: DesignType, cardElement: CardElement) -> AnyView {
        switch designType {
        case .HC3: return AnyView(HC3View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC6: return AnyView(HC6View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC5: return AnyView(HC5View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC4: return AnyView(HC4View(cardElement: cardElement,openURL: self.viewModel.openURL,parentViewModel: self.viewModel))
        case .HC1: return AnyView(HC1View(cardElement: cardElement,openURL: self.viewModel.openURL))
        }
    }
}
