//
//  WinView.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import SwiftUI

struct WinView: View {
    @Binding var currentPage: pages
    var body: some View {
        ZStack{
            Image("甘比亞背景")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            HStack{
                Text("Done")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                currentPage = pages.StoreRecordView
            }
            
            
        }
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView(currentPage: .constant(pages.WinView))
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
