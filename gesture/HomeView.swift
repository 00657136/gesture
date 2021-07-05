//
//  HomeView.swift
//  gesture
//
//  Created by 張凱翔 on 2021/4/21.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    @Binding var currentPage:pages
    
    @State private var viewAnimationOpacity = 1.0
    
    
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
                
                    
                
            
                
                
            
            
            
            
            
        }
        
        .onAppear{
            
            AVPlayer.BGM()
            AVPlayer.BGMQueuePlayer.play()
           
        }
        .onTapGesture {
            viewAnimationOpacity = 0
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                currentPage = pages.GameView
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentPage: .constant(pages.HomeView))
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
