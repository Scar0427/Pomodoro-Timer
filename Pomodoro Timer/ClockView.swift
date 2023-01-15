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
    @State var minutes = 0
    @State var seconds = 0
    @Binding var activeCronometer : Bool
    @Binding var minutosACronometar : Int
    @Binding var actualScale : Double
    //@State var timer =
    
    func UpdateTimer(){
        //secondsSinceStart += TimeConstants.updateTimerTime
    }

    
    var body: some View {

        VStack(alignment: .center){
            Circle()

                .strokeBorder(lineWidth: 10)
                .foregroundColor(Color("SecondaryColor"))
                .padding(10)
                .overlay{
                    //TODO: Hacer que el contador de tiempo en texto se actualice en el cronometro
                    Text(String(format: "%02d : %02d", minutes, seconds))
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .bold()
                }
                .overlay{
                    /*TimelineView(.periodic(from: .now, by: TimeConstants.updateTimerTime)) { context in
                     if(activeCronometer == true){
                     MutableView(seconds: $secondsSinceStart,totalTimeInMinutes: $minutosACronometar, givenDate: context.date)
                     }
                     }*/
                    //Timer.scheduledTimer(withTimeInterval: TimeConstants.updateTimerTime, repeats: true){ timer in
                        //if(activeCronometer == true){
                            //secondsSinceStart += TimeConstants.updateTimerTime
                    CompletionTimeArc(totalSeconds: minutosACronometar * 60 , actualSecond: secondsSinceStart)
                                .stroke(Color.accentColor,lineWidth: 7)
                                .rotationEffect(Angle(degrees: -90))
                        //}
                    }.onAppear{
                        Timer.scheduledTimer(withTimeInterval: TimeConstants.updateTimerTime, repeats: true){timer in
                            //print("AYUDA")
                            if(activeCronometer){
                                secondsSinceStart += TimeConstants.updateTimerTime
                                
                                let remainingTimeInSeconds = Double(minutosACronometar * 60) - round(secondsSinceStart)
                                minutes = Int(floor(remainingTimeInSeconds / 60))
                                seconds = Int(floor(remainingTimeInSeconds.truncatingRemainder(dividingBy: 60)))
                            }
                        }
                    }
            
            
            //Toggle(isOn: $activeCronometer) {
              //  Text("Debug cronometer")
            //}
        }.onChange(of: activeCronometer){_ in
            secondsSinceStart = 0.0
        }
        .scaleEffect(actualScale)
        .animation(.spring(), value: actualScale)
        /*.onChange(of: secondsSinceStart){_ in
           
        }*/
       /* #if os(macOS)
        .frame(minWidth: WindowSize.minSize.width, minHeight: WindowSize.minSize.height)
        .frame(maxWidth: WindowSize.maxSize.width, maxHeight: WindowSize.maxSize.height)
        #endif*/
    }
}


/*struct MutableView: View{
    
    @Binding var seconds: Double
    @Binding var totalTimeInMinutes : Int
    
    var body: some View{
        CompletionTimeArc(totalSeconds: totalTimeInMinutes * 60 , actualSecond:seconds)
            .stroke(Color.accentColor,lineWidth: 7)
            .rotationEffect(Angle(degrees: -90))
            /*.onChange(of: givenDate){_ in
            }*/

    }
}*/

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
       ClockView(activeCronometer: .constant(true), minutosACronometar: .constant(5), actualScale: .constant(1.0))
        
    }
}
