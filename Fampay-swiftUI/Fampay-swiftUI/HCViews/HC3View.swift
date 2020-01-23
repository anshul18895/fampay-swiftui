//
//  HC3View.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import SwiftUI
import Combine

struct HC3View: View{
    
    var cardElement: CardElement?
    var card: Card?{
        return cardElement?.cards?.first
    }
    var cta: Cta?{
        return card?.cta?.first
    }
    var openURL: PassthroughSubject<String,Never>?
    
    var body: some View{
        ZStack{
            FPImageDownload(imageUrl: card?.bgImage?.imageURL ?? "")
                .cornerRadius(12)
            ZStack{
                HStack(alignment: .bottom, spacing: 5){
                    VStack(alignment: .leading, spacing: 15){
                        Spacer()
                        
                        FPAttributedText(formated: card?.formattedTitle, font: FPFont.RobotoRegular.sizeOf(30), initialColor: Color.white, slicedArray: card?.formattedTitle?.getSepratedStrings() ?? [])
                        
                        FPAttributedText(formated: card?.formattedDescription, font: FPFont.RobotoRegular.sizeOf(15), initialColor: Color.white, slicedArray: card?.formattedDescription?.getSepratedStrings() ?? [])
                        Button.init(action: {
                            self.openURL?.send(self.cta?.url ?? "")
                        }) {
                            Text("Action").foregroundColor(.white)
                        }
                        .frame(width: 128, height: 42, alignment: .center)
                        .background(Color(.black).cornerRadius(6))
                    }
                    Spacer()
                }
            }.padding(30)
            
        }
        .aspectRatio(320/350, contentMode: .fit)
        .padding([.leading,.trailing], 15)
        .padding([.top,.bottom], 7.5)
    }
}
