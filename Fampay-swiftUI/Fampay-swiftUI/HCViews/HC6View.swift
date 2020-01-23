//
//  HC6View.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import SwiftUI
import Combine

//

struct HC6View: View{
    var cardElement: CardElement?
    var card: Card?{
        return cardElement?.cards?.first
    }
    var openURL: PassthroughSubject<String,Never>?
    
    var body: some View {
        ZStack{
            HStack{
                ZStack{
                    FPImageDownload(imageUrl: card?.icon?.imageURL ?? "")
                }
                .frame(width: 30 , height: 30)
                Text(card?.title ?? "")
                    .font(FPFont.RobotoRegular.sizeOf(14))
                Spacer()
                FPImage.arrow.image()
            }
            .padding(20)
            .background(Color(hex: card?.bgColor ?? ""))
            .cornerRadius(12)
        }
        .padding([.leading,.trailing], 15)
        .padding([.top,.bottom], 7.5)
    }
}
