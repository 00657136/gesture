//
//  GameTimer.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import Foundation

class GameTimer: ObservableObject
{
    private var frequency:Double = 1
    private var timer: Timer?
    private var startDate: Date?
    @Published var timeElapsed:Double = 0
    
    func timerStart(){
        timeElapsed = 0
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true){
            timer in
            if let startDate = self.startDate{
                self.timeElapsed = Double(timer.fireDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
            }
            
        }
    }
    
    func timerRefresh(){
        timeElapsed = 0
    }
    
    func timerStop(){
        timer?.invalidate()
        timer = nil
    }
    
    func timerPause(){
        timer?.invalidate()
        timer = nil
    }
    
    func timerContinue(){
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true){
            timer in
            self.timeElapsed += self.frequency
        }
    }
    
    func timerRestart(){
        timerStop()
        timerStart()
    }
}
