//
//  HC5View.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct HC5View: View {
    var cardElement: CardElement?
    var openURL: PassthroughSubject<String,Never>?
    
    var card: Card?{
        return cardElement?.cards?.first
    }
    var body: some View{
        ZStack{
            FPImageDownload(imageUrl: card?.bgImage?.imageURL ?? "").cornerRadius(12).gesture(
                TapGesture().onEnded({ _ in
                    print("Tapped")
                })
            )
        }.padding([.leading,.trailing], 15)
        .padding([.top,.bottom], 7.5)
    }
}
