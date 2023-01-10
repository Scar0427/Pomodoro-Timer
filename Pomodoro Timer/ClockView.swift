//
//  ClockView.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 09/01/23.
//

import SwiftUI
import Foundation

struct ClockView: View {
    
    @State var secondsSinceStart = 0.0
    @State var aDate = Date.now

    
    var body: some View {

            Circle()
                .strokeBorder(lineWidth: 10)
                .overlay{
                    Text("MM : SS")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .bold()
                }
                .overlay{
                    TimelineView(.periodic(from: .now, by: TimeConstants.updateTimerTime)) { context in
                        
                        MutableView(seconds: $secondsSinceStart, givenDate: context.date)
                       
                    }
                }

    }
}

struct MutableView: View{
    
    @Binding var seconds: Double
    var givenDate: Date
    
    var body: some View{
        CompletionTimeArc(totalSeconds: 250, actualSecond:seconds)
            .stroke(Color.accentColor,lineWidth: 7)
            .rotationEffect(Angle(degrees: -90))
            .onChange(of: givenDate){_ in
                seconds += TimeConstants.updateTimerTime
            }
    }

}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
        
    }
}
