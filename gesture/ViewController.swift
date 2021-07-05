//
//  ViewController.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//


import SwiftUI

struct ViewController: View {
    @State var currentPage = pages.HomeView
    @State var showHome = true
    @State var showGameView = true
    @State var correctNumber = 0
    @State var useTime = ""
    var body: some View {
        ZStack{
            switch currentPage
            {
                case pages.HomeView: HomeView(currentPage: $currentPage)
            case pages.GameView: GameView(currentPage: $currentPage, correctNumber: $correctNumber, useTime: $useTime)
            case pages.LoseView: LoseView(currentPage:  $currentPage)
            case pages.StoreRecordView: StoreRecordView(currentPage: $currentPage, useTime: $useTime, correctNumber: $correctNumber)
            case pages.RecordView: RecordView( currentPage: $currentPage)
            case pages.WinView: WinView(currentPage: $currentPage)
            }
        }
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}


extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

enum pages{
    case HomeView, GameView, LoseView, StoreRecordView, RecordView, WinView
}
