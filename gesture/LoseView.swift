//
//  LoseView.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import SwiftUI

struct LoseView: View {
    @Binding var currentPage: pages
    var body: some View {
        ZStack{
            Image("甘比亞背景")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("哭啊")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.height*2/3, height: UIScreen.main.bounds.width/2)
            
            Text("哭啊，時間到了")
                .font(.system(size: 20))
                .foregroundColor(Color("green"))
                .padding(.horizontal, 6.0)
                .background(Color("blue"))
                .cornerRadius(30)
                .overlay(Capsule().stroke(Color("green"), lineWidth: 1))
                .scaleEffect(2.5)
                .offset(y: 130)
                .shadow(radius: 30)
            
            
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now()+5.0){
                currentPage = pages.StoreRecordView            }
        }
    }
}

struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(currentPage: .constant(pages.LoseView))
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
