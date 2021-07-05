//
//  RecordView.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import SwiftUI

struct RecordView: View {
    @ObservedObject var gameRecord = GameRecordData()
    @Binding var currentPage: pages
    var body: some View {
        HStack{

        VStack{
            
                Form{
                    HStack{
                        Text("排行榜")
                            .font(.headline)
                            .frame(width: 100)
                        Spacer()
                        Text("玩家名稱")
                            .font(.headline)
                            .frame(width: 120)
                        Spacer()
                        Text("答對題數")
                            .font(.headline)
                            .frame(width: 100)
                        Spacer()
                        Text("花費時間")
                            .font(.headline)
                            .frame(width: 100)
                        Spacer()
                        Text("完成日期")
                            .font(.headline)
                            .frame(width: 150)
                        Spacer()
                    }
                    ForEach(gameRecord.gameRecords.indices){ item in
                        
                        ListRowView(index: item, listRow: gameRecord.gameRecords[item])
                    }
                }
            
            Text("再玩一次")
                .font(.system(size: 18))
                .foregroundColor(Color.white)
                .padding()
                .background(Color.black)
                .cornerRadius(30)
                .frame(width: UIScreen.main.bounds.width/2,alignment: .center)
                .onTapGesture {
                    currentPage = pages.HomeView
                }
                
            Spacer()
        }
        .padding()
            
        }
        .background(
            Image("甘比亞背景")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .onAppear(){
            
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
        
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(currentPage: .constant(pages.RecordView))
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
