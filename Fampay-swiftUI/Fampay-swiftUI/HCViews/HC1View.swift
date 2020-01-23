//
//  HC1View.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import SwiftUI
import Combine

struct HC1View: View {
    var cardElement: CardElement?
    var openURL: PassthroughSubject<String,Never>?
   
    var body: some View{
        ZStack{
            if cardElement?.isScrollable ?? false{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .top, spacing: 15) {
                        ForEach(cardElement?.cards ?? []){ (card) in
                            HC1ContainerView.init(card: card)
                        }
                        .frame(width: 300)
                    }
                }
            }else{
                HStack(alignment: .top, spacing: 15) {
                    ForEach(cardElement?.cards ?? []){ (card) in
                        HC1ContainerView.init(card: card)
                    }
                    .frame(minWidth: 0, maxWidth: 300)
                }
            }
        }.frame(height: 80)
        .padding([.leading,.trailing], 15)
        .padding([.top,.bottom], 7.5)
    }
}

struct HC1ContainerView: View {
    var card: Card?
    var body: some View{
        HStack{
            ZStack{
                FPImageDownload(imageUrl: card?.icon?.imageURL ?? "")
            }.frame(width: 30 , height: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                containedView(isTitle: true)
                containedView(isTitle: false)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(hex: card?.bgColor ?? "#000000"))
        .cornerRadius(12)
    }
    
    func containedView(isTitle: Bool) -> AnyView {
        if isTitle{
            if card?.isFormatedTitle ?? false{
                return AnyView(FPAttributedText(formated: (card?.formattedTitle)!, font: FPFont.RobotoMedium.sizeOf(15), initialColor: Color.black, slicedArray: (card?.formattedTitle)!.getSepratedStrings()))
            }else{
                return AnyView(Text(card?.title ?? "")
                    .foregroundColor(Color.black)
                    .font(FPFont.RobotoMedium.sizeOf(15)))
                
            }
        }
        if card?.isFormatedDesc ?? false{
            return AnyView(FPAttributedText(formated: (card?.formattedDescription)!, font: FPFont.RobotoMedium.sizeOf(14), initialColor: Color.black, slicedArray: (card?.formattedDescription)!.getSepratedStrings()))
        }else{
            return AnyView(Text(card?.cardDescription ?? "")
                .foregroundColor(Color.black)
                .font(FPFont.RobotoMedium.sizeOf(14)))
            
        }
    }
    
}
