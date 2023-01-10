//
//  CompletionTimeArc.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 09/01/23.
//

import SwiftUI

struct CompletionTimeArc: Shape{
    let totalSeconds: Int
    let actualSecond: Double
    
    private var anglesPerSecond: Double{
        360.0 / Double(totalSeconds)
    }
    
    private var endAngle: Angle{
        Angle(degrees: anglesPerSecond * Double(actualSecond))
    }
    
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height)-10
        let radius = diameter / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path{path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: endAngle, clockwise: false)
        }
    }  
    
}
