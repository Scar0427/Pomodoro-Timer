//
//  ApplicationConstants.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 10/01/23.
//

import Foundation

// An structuture that constain all constants values related to time
struct TimeConstants{
    public static let updateTimerTime = 0.01
}


#if os(macOS)
enum WindowSize{
    static let minSize = CGSize(width: 300, height: 500)
    static let maxSize = CGSize(width: 300, height: 600)
}
#endif
