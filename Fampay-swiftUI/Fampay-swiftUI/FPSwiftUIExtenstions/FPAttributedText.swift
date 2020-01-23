//
//  FPAttributedText.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI

struct FPAttributedText: View{
    var formated: Formatted!
    var font: Font?
    var initialColor: Color?
    var slicedArray: [String]
    
    var body: some View{
        ZStack{
            getArrayOfText().reduce(Text(""), {$0 + $1})
        }
    }
    
    func getArrayOfText() -> [Text]{
        var entities = self.formated.entities
        var arrText: [Text] = []
        for i in 0...(self.slicedArray.count - 1){
                if self.slicedArray[i] == "{}"{
                    let firstElement = entities?.first
                    arrText.append(
                    Text(firstElement?.text ?? "")
                            .foregroundColor(Color.init(hex: firstElement?.color ?? "#000000"))
                    )
                    entities?.removeFirst()
                }else{
                    arrText.append(Text(self.slicedArray[i]).foregroundColor(self.initialColor))
            }
        }
        return arrText
    }
    
}
