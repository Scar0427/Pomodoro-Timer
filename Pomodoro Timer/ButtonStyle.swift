//
//  ButtonStyle.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 11/01/23.
//

import Foundation
import SwiftUI

struct MacOSButtonLikeIOS: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(configuration.isPressed ? Color.accentColor.opacity(0.5) : Color.accentColor)
            .cornerRadius(5)
    }
}
