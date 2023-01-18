//
//  ApplicationConvertionSystem.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 17/01/23.
//

import Foundation


//Esta función se encarga de enviar un String en el formato 'mm minutos' o 'hh:mm horas' segun la entrada que reciba en minutos.
func ConvertMinutesToHourMinutesString(minutos: Int) -> String{
    let totalDeHoras = Int(floor(Double(minutos / 60)))
    let totalDeMinutos = Int(round(Float(minutos).truncatingRemainder(dividingBy: 60)))
    
    //No hay horas completas
    if(totalDeHoras <= 0){
        let returnString = String(format: "%02d minutos", totalDeMinutos)
        return returnString
    }else{
        print(totalDeHoras)
        let returnString = String(format: "%02d:%02d horas", totalDeHoras, totalDeMinutos)
        print(returnString)
        return returnString
    }
}
