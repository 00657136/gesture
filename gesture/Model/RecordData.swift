//
//  RecordData.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import Foundation
import SwiftUI

struct GameRecord :Identifiable, Codable{
    var id = UUID()
    var number :Int
    var playerName : String
    var correctNumber : Int
    var playTime : String
    var DateTime : Date
}

class GameRecordData : ObservableObject {
    @AppStorage("gamerecordData") var gamerecordData:Data?
    
    init() {
        if let ClassesData = gamerecordData {
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode([GameRecord].self, from: ClassesData){
                gameRecords = decodedData
                sortData()
            }
        }
    }
    
    
    @Published var gameRecords = [GameRecord](){
        didSet{
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(gameRecords)
                gamerecordData = data
            } catch {
            }
        }
    }
    
    func sortData()
        {
            gameRecords.sort{
                if($0.correctNumber != $1.correctNumber){
                    //print("\($0.name) completon = \($0.completion), \($1.name) completon = \($1.completion)")
                    return $0.correctNumber > $1.correctNumber
                }
                else if($0.playTime != $1.playTime){
                    //print("\($0.name) completon = \($1.name) completon")
                    return $0.playTime < $1.playTime
                }
                else{
                    //print("\($0.name) useTime = \($1.name) useTime")
                    return $0.DateTime <= $1.DateTime
                }
            }
        }
}
