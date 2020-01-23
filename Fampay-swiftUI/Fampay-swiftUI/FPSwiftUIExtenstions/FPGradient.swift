//
//  FPGrediant.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI

struct FPGrediant: View{
    var colors: [String] = []
    var gradientLayer: GradientUtility = GradientUtility(angle: 60)
    var body: some View{
        LinearGradient.init(gradient: Gradient.init(colors: self.colors.map({Color.init(hex: $0)})), startPoint: .init(x: gradientLayer.startPoint.x, y: gradientLayer.startPoint.y), endPoint: .init(x: gradientLayer.endPoint.x, y: gradientLayer.endPoint.y))
    }
}

struct GradientUtility {
    
    var startPoint: CGPoint = CGPoint.zero
    var endPoint: CGPoint = CGPoint.zero
    
    init(angle: CGFloat){
        self.startPoint = gradientPointsForAngle(angle).0
        self.endPoint = gradientPointsForAngle(angle).1
    }
    
    private func gradientPointsForAngle(_ angle: CGFloat) -> (CGPoint, CGPoint) {
        // get vector start and end points
        let end = pointForAngle(angle)
        let start = oppositePoint(end)
        // convert to gradient space
        let p0 = transformToGradientSpace(start)
        let p1 = transformToGradientSpace(end)
        return (p0, p1)
    }
    private func pointForAngle(_ angle: CGFloat) -> CGPoint {
        // convert degrees to radians
        let radians = angle * .pi / 180.0
        var x = cos(radians)
        var y = sin(radians)
        // (x,y) is in terms unit circle. Extrapolate to unit square to get full vector length
        if (abs(x) > abs(y)) {
            // extrapolate x to unit length
            x = x > 0 ? 1 : -1
            y = x * tan(radians)
        } else {
            // extrapolate y to unit length
            y = y > 0 ? 1 : -1
            x = y / tan(radians)
        }
        return CGPoint(x: x, y: y)
    }

    private func oppositePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }

    private func transformToGradientSpace(_ point: CGPoint) -> CGPoint {
        // input point is in signed unit space: (-1,-1) to (1,1)
        // convert to gradient space: (0,0) to (1,1), with flipped Y axis
        return CGPoint(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
    }
    
}
