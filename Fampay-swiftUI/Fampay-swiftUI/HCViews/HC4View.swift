//
//  HC4View.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import SwiftUI
import Combine

struct HC4View: View {
    
    var cardElement: CardElement?
    var card: Card?{
        return cardElement?.cards?.first
    }
    var openURL: PassthroughSubject<String,Never>?
    var parentViewModel: HomeViewModel?
    var cardActions: [Cta]{
        return card?.cta ?? []
    }
    
    var body: some View{
        ZStack{
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                VStack(alignment: .center, spacing: 5){
                    Spacer()
                    ZStack{
                        FPImageDownload(imageUrl: card?.icon?.imageURL ?? "")
                            .background(Color.init(.black))
                            .frame(width: 50.0, height: 50.0, alignment: .center)
                            .cornerRadius(25)
                    }.padding(10)
                    
                    FPAttributedText(formated: self.cardElement?.cards?.first?.formattedTitle, font: FPFont.RobotoRegular.sizeOf(18), initialColor: Color.black, slicedArray: self.cardElement?.cards?.first?.formattedTitle?.getSepratedStrings() ?? [])
                    
                    Text("Arya Stark")
                    
                    ZStack{
                        HStack(alignment: .top, spacing: 20){

                            
                            Button.init("Button1") {
                                self.parentViewModel?.apply(.onOpenURL(url: "Button 1"))
                            }
                            
                            Button.init("Button2") {
                                self.parentViewModel?.apply(.onOpenURL(url: "Button 2"))
                            }
                            
//                            Button(action: {
//                                self.parentViewModel?.apply(.onOpenURL(url: "Button 1"))
//                            }){
//                                Text(cardActions.first?.text ?? "")
//                                    .foregroundColor(Color(hex: cardActions.first?.textColor ?? "#000000"))
//                            }.frame(width: 128, height: 42, alignment: .center)
//                                .background(Color(hex: cardActions.last?.bgColor ?? "#FFFFFF").cornerRadius(4))
//                            
//                            Button(action: {
//                                self.parentViewModel?.apply(.onOpenURL(url: "Button 2"))
//                            }){
//                                Text(cardActions.last?.text ?? "")
//                                    .foregroundColor(Color(hex: cardActions.last?.textColor ?? "#000000"))
//                            }.frame(width: 128, height: 42, alignment: .center)
//                                .background(Color(hex: cardActions.last?.bgColor ?? "#FFFFFF").cornerRadius(4))
                            
                        }
                    }.padding(.top, 10)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }.background(
            FPGrediant(colors: card?.bgGradient?.colors ?? [], gradientLayer: GradientUtility(angle: CGFloat(card?.bgGradient?.angle ?? 60)))
                .cornerRadius(12)
        ).padding([.leading,.trailing], 15)
            .padding([.top,.bottom], 7.5)
            .aspectRatio(1.630, contentMode: .fit)
    }
    
    func _openURL(string: String){
        self.openURL?.send(string)
    }
}
