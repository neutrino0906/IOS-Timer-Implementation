//
//  TimerInteractor.swift
//  TimerApp
//
//  Created by Ground 2 on 18/03/24.
//

import Foundation
import UIKit

class TimerInteractor: InteractorProtocol{
    
    var view : HomeViewController?
    var presenter : TimerPresenter?
    
    
    var timer = Timer()
    var timerForLabel = Timer()
    var currentSpeed = 1.0
    
    
    
    func updateSpeed(_ speed: Float) {
        currentSpeed = Double(speed)
    }
    
    func timerValidate(){
        timer = Timer.scheduledTimer(timeInterval: 1.0/currentSpeed, target: self, selector: #selector(labelUpdated), userInfo: nil, repeats: true)
        timerForLabel = Timer.scheduledTimer(timeInterval: 1.0/currentSpeed, target: self, selector: #selector(labelUpdated), userInfo: nil, repeats: true)
    }
    
    func timerStarted() {
        
        timerValidate()
    }
    
    @objc func labelUpdated() {
        view?.setLabel()
        view?.setCircularBar()
    }
    
    func timerResetted(){
        timer.invalidate()
        timerForLabel.invalidate()
        
        view?.currentSeconds = 1860
        view?.currentProgress = 1860.0
        view?.circularBarView.progressLayer.strokeEnd = 1.0
    }
    
    
    func timerInvalidate() {
        timer.invalidate()
    }
    
    func timerForLabelInvalidate() {
        timerForLabel.invalidate()
    }
    
    
}
