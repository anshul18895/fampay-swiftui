//
//  FPUtility.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum FPFont: String{
    case RobotoRegular = "Roboto-Regular"
    case RobotoBlack = "Roboto-Black"
    case RobotoLight = "Roboto-Light"
    case RobotoBoldItalic = "Roboto-BoldItalic"
    case RobotoLightItalic = "Roboto-LightItalic"
    case RobotoThin = "Roboto-Thin"
    case RobotoMediumItalic = "Roboto-MediumItalic"
    case RobotoMedium = "Roboto-Medium"
    case RobotoBlackItalic = "Roboto-BlackItalic"
    case RobotoItalic = "Roboto-Italic"
    case RobotoThinItalic = "Roboto-ThinItalic"
    
    func sizeOf(_ size: CGFloat) -> Font{
        return Font.custom(self.rawValue, size: size)
    }
}

enum FPImage: String{
    case arrow
    case titleLogo = "fampayTitle"
    func image()->Image{
        return Image(self.rawValue)
    }
}
