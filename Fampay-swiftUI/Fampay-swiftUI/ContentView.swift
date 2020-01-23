//
//  ContentView.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import SwiftUI

struct HC6View: View{
    var cardElement: CardElement?
    var body: some View {
        ZStack{
            HStack{
                ZStack{
                    FPImageDownload(imageUrl: cardElement?.cards?.first?.icon?.imageURL ?? "")
                }
                .frame(width: 30 , height: 30)
                Text(cardElement?.cards?.first?.title ?? "")
                    .font(FPFont.RobotoRegular.sizeOf(14))
                Spacer()
                FPImage.arrow.image()
            }
            .padding(20)
            .background(Color(hex: cardElement?.cards?.first?.bgColor ?? ""))
            .cornerRadius(12)
        }
        .padding([.leading,.trailing], 15)
        .padding([.top,.bottom], 7.5)
    }
}

struct HC3View: View{
    
    var cardElement: CardElement?
    
    var body: some View{
        ZStack{
            FPImageDownload(imageUrl: self.cardElement?.cards?.first?.bgImage?.imageURL ?? "")
                .cornerRadius(12)
            ZStack{
                HStack(alignment: .bottom, spacing: 5){
                    VStack(alignment: .leading, spacing: 15){
                        Spacer()
                        FPAttributedText(formated: self.cardElement?.cards?.first?.formattedTitle, font: FPFont.RobotoRegular.sizeOf(25), initialColor: Color.white, slicedArray: self.cardElement?.cards?.first?.formattedDescription?.getSepratedStrings() ?? [])
                        FPAttributedText(formated: self.cardElement?.cards?.first?.formattedDescription, font: FPFont.RobotoRegular.sizeOf(15), initialColor: Color.white, slicedArray: self.cardElement?.cards?.first?.formattedDescription?.getSepratedStrings() ?? [])
                        Button(action: {}) {
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

struct HC4View: View {
    var body: some View{
        ZStack{
            HStack(alignment: .center, spacing: 10){
                Spacer()
                VStack(alignment: .center, spacing: 20){
                    Spacer()
                    FPImageDownload(imageUrl: "").background(Color.init(.black)).contentShape(Circle()).frame(width: 40, height: 40, alignment: .center)
                    Text("Arya Stark")
                    Text("Arya Stark")
                    HStack{
                        Button(action: {}) {
                            Text("Action 1")
                        }
                        .frame(width: 100, height: 30, alignment: .center)
                        .background(Color(.black))
                        Button(action: {}) {
                            Text("Action 2")
                        }
                        .frame(width: 100, height: 30, alignment: .center)
                        .background(Color(.black))
                    }
                    Spacer()
                }
                Spacer()
            }
            
        }.background(
            FPGrediant(colors: ["#FBAF03","#FFD428"], gradientLayer: GradientUtility(angle: 60))
                .cornerRadius(12)
        ).padding(5).aspectRatio(1.630, contentMode: .fit)
    }
}

struct HC5View: View {
    var cardElement: CardElement?
    var body: some View{
        ZStack{
            FPImageDownload(imageUrl: cardElement?.cards?.first?.bgImage?.imageURL ?? "").cornerRadius(12).gesture(
                TapGesture().onEnded({ _ in
                    print("Tapped")
                })
            )
            
        }.padding([.leading,.trailing], 15)
        .padding([.top,.bottom], 7.5)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack{
            HC6View()
        }.background(Color.gray)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
