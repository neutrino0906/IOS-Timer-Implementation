//
//  TimerPresenter.swift
//  TimerApp
//
//  Created by Ground 2 on 18/03/24.
//

import Foundation
import UIKit

class TimerPresenter : PresenterProtocol{
    

    var interactor : TimerInteractor?
    var view : UIViewController?
    
    func updateSpeed(_ speed: Float) {
        interactor?.updateSpeed(speed)
    }
    
    func startTimer() {
        interactor?.timerStarted()
    }
    
    func resetTimer() {
        interactor?.timerResetted()
    }
    
    
    func timerInvalidate() {
        interactor?.timerInvalidate()
    }
    
    func timerForLabelInvalidate() {
        interactor?.timerForLabelInvalidate()
    }
    func timerValidate() {
        interactor?.timerValidate()
    }
    
}
