//
//  Protocols.swift
//  TimerApp
//
//  Created by Ground 2 on 18/03/24.
//

import Foundation


protocol ViewProtocol{
    
    func startTimer()
    func resetTimer()
    func pauseTimer()
}

protocol PresenterProtocol{
    
    func startTimer()
    func resetTimer()
    func updateSpeed(_ speed: Float)
    func timerInvalidate()
    func timerForLabelInvalidate()
    func timerValidate()
    
}

protocol InteractorProtocol{
    
    func timerStarted()
    func labelUpdated()
    func timerResetted()
    func updateSpeed(_ speed: Float)
    func timerInvalidate()
    func timerForLabelInvalidate()
    func timerValidate()
    
}
