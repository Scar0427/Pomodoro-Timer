//
//  MainScreen.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 11/01/23.
//

import SwiftUI

struct MainScreen: View {
    
    @State var cronometerActualTime = false
    @State var inTimeConfiguration = false
    @State var minutosNormal = 25
    @State var minutosDescanso = 5
    //Un ciclo es el tiempo total de minutosNormal y de Descanso. Mientras los ciclos no terminen, la app ira repitiendo el bucle hasta terminar todos.
    @State var ciclosAntesDeParar = 8
    
    @State var actualTimeSpace = 0
    @State var hidingElementsScale = 1.0
    @State var clockFrameSize = 200.0
    
    var body: some View {
        VStack{
            Text("POMODORO TIMER")
                .font(.largeTitle)
                .bold()
                .padding(15)

                ClockView(activeCronometer: $cronometerActualTime, minutosACronometar: $actualTimeSpace, actualScale: $hidingElementsScale)
                    .frame(height: clockFrameSize)
                
                Button(cronometerActualTime ? "Detener temporizador" : "Iniciar temporizador"){
                    actualTimeSpace = minutosNormal
                    cronometerActualTime.toggle()
                    
                    //TODO: Hay que configuar el temporizador según que fue el útlimo estado (o sea, que tras un temporizador de descanso, empiece otro de trabajo y así), además de agendar todo el sistema de notificaciones.
                }.padding(5)
                .scaleEffect(hidingElementsScale)
#if os(macOS)
                .buttonStyle(MacOSButtonLikeIOS())
#elseif os(iOS)
                .buttonStyle(.borderedProminent)
#endif

        
            
            Button(inTimeConfiguration ? "Guardar tiempos" : "Configurar tiempos"){
                inTimeConfiguration.toggle()
                if(inTimeConfiguration){
                    hidingElementsScale = 0.0
                    clockFrameSize = 0.0
                }else{
                    hidingElementsScale = 1.0
                    clockFrameSize = 200.0
                }
            }
            .padding(5)
            #if os(macOS)
            .buttonStyle(MacOSButtonLikeIOS())
            #elseif os(iOS)
            .buttonStyle(.borderedProminent)
            #endif
            
            if(cronometerActualTime == false){
                if(inTimeConfiguration == false){
                    //Se muestran los tiempos que esta configurado ahorita la app
                    VStack{
                        Text("Tiempo Configurados:")
                            .font(.title3)
                            .bold()
                        HStack{
                            Text("Normal: ").bold()
                            Text("\(minutosNormal) minutos")
                        }.padding(5)
                        HStack{
                            Text("Descanso: ").bold()
                            Text("\(minutosDescanso) minutos")
                        }.padding(5)
                        HStack{
                            Text("Tiempo de ejecución: ").bold()
                            Text("\(ConvertMinutesToHourMinutesString(minutos: ciclosAntesDeParar * (minutosNormal + minutosDescanso)))")
                        }
                    }
                    .padding(10)
                }else{
                    //Se cambia la UI para pasar a cofigurar los tiempos
                    VStack{
                        Stepper(value: $minutosNormal, in: 1...120) {
                            Text("Normal: \(minutosNormal)")
                        }
                        Stepper(value: $minutosDescanso, in: 1...30) {
                            Text("Descanso: \(minutosDescanso)")
                        }
                        Stepper(value: $ciclosAntesDeParar, in: 1...30) {
                            Text("Tiempo de ejecución: \(ConvertMinutesToHourMinutesString(minutos: ciclosAntesDeParar * (minutosNormal + minutosDescanso)))")
                        }
                    }.padding(10)
                }
                
            }
        }
        .animation(.spring(), value: hidingElementsScale)
        .animation(.spring(), value: clockFrameSize)
        #if os(macOS)
        .frame(minWidth: WindowSize.minSize.width, maxWidth: WindowSize.maxSize.width, minHeight: WindowSize.minSize.height, maxHeight: WindowSize.maxSize.height, alignment: .top)
        #elseif os(iOS)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200, alignment: .top)
        #endif
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
