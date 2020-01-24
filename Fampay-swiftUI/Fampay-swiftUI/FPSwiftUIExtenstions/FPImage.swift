//
//  FPImage.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 24/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI
import struct Kingfisher.KFImage

struct FPImageDownload: View {
    var imageUrl: String
    var body: some View{
        KFImage(URL(
            string: imageUrl
            )).resizable().aspectRatio(contentMode: .fit).clipped()
    }
}

