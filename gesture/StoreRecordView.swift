//
//  StoreRecordView.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import SwiftUI

struct StoreRecordView: View {
    @State var playerName = ""
    @State var saveData = true
    @StateObject var gameRecord = GameRecordData()
    @State var date = Date()
    @Binding var currentPage: pages
    @Binding var useTime: String
    @Binding var correctNumber: Int
    let formatter = DateFormatter()
          
   
    var body: some View {
        ZStack{
            Image("甘比亞背景")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
                    
            
                Image("封面")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height*2/3, height: UIScreen.main.bounds.width/2)
                    .offset(y: -15)
        
        
            
            
            
                Text("Wolof拼字大挑戰")
                    .font(.system(size: 20))
                    .foregroundColor(Color("green"))
                    .padding(.horizontal, 6.0)
                    .background(Color("blue"))
                    .cornerRadius(30)
                    .overlay(Capsule().stroke(Color("green"), lineWidth: 1))
                    .scaleEffect(2.5)
                    .offset(y: 130)
                    .shadow(radius: 30)
                
                
                VStack{
                    Form{
                        HStack{
                            Text("姓名：")
                            TextField("請輸入姓名", text: $playerName)
                        }
                        HStack{
                            Text("日期：")
//                            Spacer()
                            Text(date, formatter: formatter)
                        }
                        HStack{
                            Text("分數：")
                            Text("共答對 \(correctNumber) 題")
                            Spacer()
                            Text("儲存")
                                .foregroundColor(.blue)
                                .onTapGesture {
//                                    saveData = true
                                    if playerName.isEmpty {
                                        playerName = ""
                                    }
                                    let playerdata = GameRecord(number: 0, playerName: playerName, correctNumber: correctNumber, playTime: useTime, DateTime: date)
                                    
                                    gameRecord.gameRecords.append(playerdata)
                                    currentPage = pages.RecordView
                                }
                        }
                        
                        
                    }
                    .frame(width: 500, height: 210, alignment: .center)
                    
                    
                    
                    
                }
                
                
                
            
            
            
            
        }
        .onAppear(){
            formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
    }
}

struct StoreRecordView_Previews: PreviewProvider {
    static var previews: some View {
        StoreRecordView(currentPage: .constant(pages.StoreRecordView), useTime: .constant("60"), correctNumber: .constant(2) )
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
