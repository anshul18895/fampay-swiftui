//
//  ContentView.swift
//  MovieApp
//
//  Created by Anshul on 04/02/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List{
            ZStack{
                HStack{
                    VStack(alignment: .leading, spacing: 20){
                        Image("")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 100, alignment: .center)
                            .background(Color.black)
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 5){
                        Text("Hello World")
                        Text("Hello World")
                        Text("World World World World dfsddfsdmf,f,dmfmd,fdWorld Worldddd World World World World World World World World World World World World World World World World")
                        Spacer()
                    }
                    Spacer()
                }.padding(5)
                }.background(Color.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
