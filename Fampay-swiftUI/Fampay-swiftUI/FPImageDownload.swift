//
//  FPImageView.swift
//  
//
//  Created by Anshul on 22/01/20.
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
