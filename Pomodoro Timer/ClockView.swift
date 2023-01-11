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
    @Binding var activeCronometer : Bool
    @Binding var minutosACronometar : Int

    
    var body: some View {

        VStack(alignment: .center){
            Circle()
                .strokeBorder(lineWidth: 10)
                .foregroundColor(Color("SecondaryColor"))
                .padding(10)
                .overlay{
                    //TODO: Hacer que el contador de tiempo en texto se actualice en el cronometro
                    Text("MM : SS")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .bold()
                }
                .overlay{
                    TimelineView(.periodic(from: .now, by: TimeConstants.updateTimerTime)) { context in
                        if(activeCronometer == true){
                            MutableView(seconds: $secondsSinceStart,totalTimeInMinutes: $minutosACronometar, givenDate: context.date)
                        }
                    }
                }
        }.onChange(of: activeCronometer){_ in
            secondsSinceStart = 0.0
        }
       /* #if os(macOS)
        .frame(minWidth: WindowSize.minSize.width, minHeight: WindowSize.minSize.height)
        .frame(maxWidth: WindowSize.maxSize.width, maxHeight: WindowSize.maxSize.height)
        #endif*/
    }
}

struct MutableView: View{
    
    @Binding var seconds: Double
    @Binding var totalTimeInMinutes : Int
    var givenDate: Date
    
    var body: some View{
        CompletionTimeArc(totalSeconds: totalTimeInMinutes * 60 , actualSecond:seconds)
            .stroke(Color.accentColor,lineWidth: 7)
            .rotationEffect(Angle(degrees: -90))
            .onChange(of: givenDate){_ in
                seconds += TimeConstants.updateTimerTime
            }

    }

}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(activeCronometer: .constant(true), minutosACronometar: .constant(5))
        
    }
}
