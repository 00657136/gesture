//
//  GameView.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    
    @Binding var currentPage:pages
    @Binding var correctNumber:Int
    @Binding var useTime:String
    
    @State private var showGameView = true
    @State private var scale:CGFloat = 1
    @State private var showStartText = false
    @State private var viewAnimationOpacity = 1.0
    @State var question = [SingleRole]()
    @State var questioncheck = [SingleRole]()
    @State var answer = [SingleRole]()
    let wordCirclesize:CGFloat = 60
    @State var wordImage = ""
    @State var wordCircleFrame = [CGRect]()
    @State var wordCircleFrameRecord = [CGRect]()
    @State var answerCircleFrame = [CGRect]()
    @State var questionhide = [Bool]()
    @State var answerCirclehide = [Bool]()
    @State private var offset = [CGSize]()
    @State private var newPosition = [CGSize]()
    @State private var answerIndexCorrect = 0
    @State private var posCreated = [Bool]()
    @State private var stageTraisition = false
    @State var showGameSettingView = false
    @State var voiceClose = false
    var playCorrectVoice: AVPlayer { AVPlayer.VoiceCorrectPlayer }
    var playwroungVoice: AVPlayer { AVPlayer.VoiceWroungPlayer }
    var playNextVoice: AVPlayer { AVPlayer.VoiceNextPlayer }
    @State var gameStage :Int = 0
    @State var playVocabularyControll = false
    @StateObject var gameTime = GameTimer()
    @State var timeRemain :Double = 250
    @State var showTimeRemain :Double = 250
    let totalTime :Double = 250
    @State var isFirstIn = true
    @State var timeRectremain :CGFloat = 250
    
    var body: some View {
        HStack{
            VStack{
                if voiceClose == true{
                    Button(action: {
                        
                        voiceClose.toggle()
                        AVPlayer.BGMQueuePlayer.play()
                        
                    }) {
                       
                        Image(systemName: "music.note")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            
                        
                    }
                    .padding(.leading)
                    .foregroundColor(.white)
                }else{
                    Button(action: {
                        voiceClose.toggle()
                        AVPlayer.BGMQueuePlayer.pause()
                    }) {
                       
                        Image(systemName: "pause.circle")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            
                        
                    }
                    .padding(.leading)
                    .foregroundColor(.white)
                }
                Spacer()
            }
            .offset(y: 25)
            Spacer()
            VStack{
                Spacer()
                HStack{
                    ForEach(Array(question.enumerated()),id:\.element.id) { index,role in
                        ZStack{
                            Circle()
                                .foregroundColor(.white)
                                .opacity(0.3)
                                .frame(width: wordCirclesize, height: wordCirclesize, alignment: .center)
                            Circle()
                                .stroke(Color.white,lineWidth:5)
                                .frame(width: wordCirclesize, height: wordCirclesize, alignment: .center)
                            Text(role.vocabulary)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                            
                            
                        }
                        .isHidden(questionhide[index])
                        .offset(offset[index])
                        .padding(.horizontal, 10.0)
                        .overlay(
                            GeometryReader(content: { geometry in
                                Color.clear
                                    .onAppear{
                                        let _ = updateFrame(geometry: geometry, index: index)
                                        
                                    }
                            })
                        )
                        .gesture(
                            DragGesture()
                                .onChanged({ (Value) in
                                    playVocabulary(isPlayed: playVocabularyControll, vocabulary: question[index].vocabulary)
                                    offset[index].width = newPosition[index].width + Value.translation.width
                                    offset[index].height = newPosition[index].height + Value.translation.height
                                    
                                    
                                })
                                .onEnded({ (value) in
                                    wordCircleFrameRecord[index] = wordCircleFrame[index]
                                    wordCircleFrame[index].origin.x = wordCircleFrame[index].origin.x + value.translation.width
                                    wordCircleFrame[index].origin.y = wordCircleFrame[index].origin.y + value.translation.height
                                    
                                    
                                    isCorrectword(wordCircleFrame1: wordCircleFrame[index], answerCircleFrame1: answerCircleFrame, index: index)
                                    
                                    newPosition[index] = offset[index]
                                    playVocabularyControll = false
                                    
                                    
                                    if isAllCorrect(correctCheck: answerCirclehide){
                                        wordSound(word: rolesSwordsman[gameStage].JPname)
                                        gameTime.timerPause()
                                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                            playNextVoice.playFromStart()
                                            stageTraisition = true
                                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                                                nextStage()
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                })
                            
                        )
                        .onTapGesture {
                            wordSound(word: question[index].vocabulary)
                        }
                        
                        
                    }
                }
                
                if stageTraisition  {
                    Spacer()
                    Image("水啦")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.height*2/3, height: UIScreen.main.bounds.width/2)
                    Spacer()
                }else{
                    Image(wordImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180, alignment: .center)
                        .onTapGesture {
                            wordSound(word: rolesSwordsman[gameStage].JPname)
                        }
                }
                    
                
               
                
                HStack{
                    ForEach(Array(answer.enumerated()),id:\.element.id) { index,role in
                        if role.vocabulary != " "{
                            ZStack{
                                Circle()
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                                    .frame(width: wordCirclesize, height: wordCirclesize, alignment: .center)
                                Circle()
                                    .stroke(Color.white,lineWidth:3)
                                    .frame(width: wordCirclesize, height: wordCirclesize, alignment: .center)
                                Text(role.vocabulary)
                                    .font(.largeTitle)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.heavy/*@END_MENU_TOKEN@*/)
                                    .background(
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(width: wordCirclesize, height: wordCirclesize, alignment: .center)
                                    )
                                    .isHidden(answerCirclehide[index])
                                
                                
                            }
                            .padding(.horizontal, 10.0)
                            .overlay(
                                GeometryReader(content: { geometry in
                                    Color.clear
                                        .onAppear(){
                                            if role.vocabulary != " "{
                                                if index > answerIndexCorrect{
                                                    let recorrectIndex = index - 1
                                                    answerCircleFrame[recorrectIndex] = geometry.frame(in: .global)
                                                }else{
                                                    answerCircleFrame[index] = geometry.frame(in: .global)
                                                }
                                            }
                                            
                                        }
                                })
                            )
                        }else{
                            Text(role.vocabulary)
                                .font(.largeTitle)
                                .fontWeight(/*@START_MENU_TOKEN@*/.heavy/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal, 10.0)
                            
                        }
                    }
                    
                    
                }
                
            }
            Spacer()
            VStack{
                Spacer()
                
                Spacer()
                ZStack(alignment: .bottom){
                    
                    Rectangle()
                        .cornerRadius(5)
                        .frame(width: 35, height: timeRectremain)
                        .foregroundColor(Color("blue"))
                        .onChange(of: gameTime.timeElapsed, perform: { value in
                            let rectOftimeRate = Double(250/totalTime)
                            let Temp = Double(gameTime.timeElapsed)
                            let Temp1 = 250 - rectOftimeRate * Temp
                            if Temp1 >= 0{
                                timeRectremain = CGFloat(Temp1)
                                
                            }else{
                                timeRectremain = 0
                                
                            }
                        })
                        
                    
                    Rectangle()
                        .stroke(Color("green") ,lineWidth:5)
                        .cornerRadius(5)
                        .frame(width: 35, height: 250)
                   
                }
                    
                Text("\(showTimeRemain, specifier: "%.0f")s")
                    .font(.system(size: 20))
                    .foregroundColor(Color("green"))
                    .padding(.horizontal, 6.0)
                    .background(Color("blue"))
                    .cornerRadius(5)
                    .overlay(Capsule().stroke(Color("green"), lineWidth: 1))
                    .onChange(of: gameTime.timeElapsed , perform: { value in
                        if (timeRemain>0){
                            timeRemain = totalTime - value
                            
                            showTimeRemain = Double(lround(timeRemain))
                            if showTimeRemain < 0 {
                                showTimeRemain = 0
                            }
                            print(showTimeRemain,timeRemain)
                        }
                        else{
                            
                            gameTime.timerStop()
                            correctNumber = gameStage
                            let Temp = Int(gameTime.timeElapsed)
                            useTime = String(Temp)
                            currentPage = pages.LoseView
                            showTimeRemain = 30
                            timeRemain = 30
                            gameTime.timerRefresh()
                        }
                    })
            }
            Spacer()
        }
        
        .background(
            Image("甘比亞背景")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .onAppear(){
            if isFirstIn{
                initialGame()
                isFirstIn = false
                
            }
            
            
        }    }
    
    func initialGame()  {
        clearMatrix()
        rolesSwordsman.shuffle()
        gameStage = 0
        let translateSingleword = rolesSwordsman[gameStage].JPname
        wordImage = rolesSwordsman[gameStage].chname
        for i in 0..<translateSingleword.count {
            if let j = translateSingleword.index(translateSingleword.startIndex, offsetBy: i , limitedBy: translateSingleword.endIndex){
                let Temp = String(translateSingleword[j])
                if Temp != " "{
                    question.append(SingleRole(vocabulary: Temp))
                    questioncheck.append(SingleRole(vocabulary: Temp))
                    offset.append(CGSize.zero)
                    newPosition.append(CGSize.zero)
                    wordCircleFrame.append(CGRect.zero)
                    wordCircleFrameRecord.append(CGRect.zero)
                    answerCircleFrame.append(CGRect.zero)
                    questionhide.append(false)
                    posCreated.append(false)

                }else{
                    answerIndexCorrect = i
                }
                answerCirclehide.append(true)
                answer.append(SingleRole(vocabulary: Temp))

            }

        }
        question.shuffle()
        wordSound(word: rolesSwordsman[gameStage].JPname)
        gameTime.timerStart()
    }
    func nextStage() {
        if !(gameStage == rolesSwordsman.count - 1) {
            stageTraisition = false
            clearMatrix()
            gameStage = gameStage + 1
            let translateSingleword = rolesSwordsman[gameStage].JPname
            wordImage = rolesSwordsman[gameStage].chname
            for i in 0..<translateSingleword.count {
                if let j = translateSingleword.index(translateSingleword.startIndex, offsetBy: i , limitedBy: translateSingleword.endIndex){
                    let Temp = String(translateSingleword[j])
                    if Temp != " "{
                        question.append(SingleRole(vocabulary: Temp))
                        questioncheck.append(SingleRole(vocabulary: Temp))
                        offset.append(CGSize.zero)
                        newPosition.append(CGSize.zero)
                        wordCircleFrame.append(CGRect.zero)
                        wordCircleFrameRecord.append(CGRect.zero)
                        answerCircleFrame.append(CGRect.zero)
                        questionhide.append(false)
                        posCreated.append(false)

                    }else{
                        answerIndexCorrect = i
                    }
                    answerCirclehide.append(true)
                    answer.append(SingleRole(vocabulary: Temp))

                }

            }
            question.shuffle()
            wordSound(word: rolesSwordsman[gameStage].JPname)
            gameTime.timerContinue()
        }else{
            finishGame()
        }
        
    }
    func updateFrame(geometry: GeometryProxy, index: Int) {
        let frame = geometry.frame(in: .global)
        if(!posCreated[index]){
            wordCircleFrame[index] = frame
            posCreated[index] = true
        }

    }

    func isCorrectword(wordCircleFrame1:CGRect,answerCircleFrame1:[CGRect],index:Int){
        for i in answerCircleFrame1.indices {
            if !wordCircleFrame1.intersection(answerCircleFrame[i]).isNull {
                if i != answerCircleFrame1.count-1{
                    let rect = wordCircleFrame1.intersection(answerCircleFrame[i])
                    let rectarea = Double(rect.width * rect.height)
                    let rect1 = wordCircleFrame1.intersection(answerCircleFrame[i+1])
                    let rectarea1 = Double(rect1.width * rect1.height)
                    if rectarea >= rectarea1{
                        if i >= answerIndexCorrect{
                            let correcti = i + 1
                            if question[index].vocabulary == answer[correcti].vocabulary{
                                questionhide[index] = true
                                answerCirclehide[correcti] = false
                                playCorrectVoice.playFromStart()
                                return

                            }else{
                                offset[index].width = 0
                                offset[index].height = 0
                                wordCircleFrame[index] = wordCircleFrameRecord[index]
//                                                        playwroungVoice.playFromStart()

                            }
                        }else{
                            if question[index].vocabulary == answer[i].vocabulary{
                                questionhide[index] = true
                                answerCirclehide[i] = false
                                playCorrectVoice.playFromStart()
                                return
                            }else{
                                offset[index].width = 0
                                offset[index].height = 0
                                wordCircleFrame[index] = wordCircleFrameRecord[index]
//                                                        playwroungVoice.playFromStart()

                            }
                        }
                    }
                }else{
                    let rect = wordCircleFrame1.intersection(answerCircleFrame[i])
                    let rectarea = Double(rect.width * rect.height)
                    let rect1 = wordCircleFrame1.intersection(answerCircleFrame[i-1])
                    let rectarea1 = Double(rect1.width * rect1.height)
                    if rectarea >= rectarea1{
                        let correcti = i + 1
                        if question[index].vocabulary == answer[correcti].vocabulary{
                            questionhide[index] = true
                            answerCirclehide[correcti] = false
                            playCorrectVoice.playFromStart()
                            return
                        }else{
                            offset[index].width = 0
                            offset[index].height = 0
                            wordCircleFrame[index] = wordCircleFrameRecord[index]
//                                                    playwroungVoice.playFromStart()

                        }
                    }


                }



            }else{
                offset[index].width = 0
                offset[index].height = 0
                wordCircleFrame[index] = wordCircleFrameRecord[index]

            }
        }
    }

    func playVocabulary(isPlayed:Bool , vocabulary:String){
        if !isPlayed {
            wordSound(word: vocabulary)
            playVocabularyControll = true
        }
    }
    func isAllCorrect(correctCheck:[Bool]) -> Bool {
        for item in correctCheck.indices {
            if correctCheck[item] && item != answerIndexCorrect{
                return false
            }

        }
        return true
    }
    func finishGame(){
        gameTime.timerStop()
        correctNumber = gameStage + 1
        let Temp = Int(gameTime.timeElapsed)
        useTime = String(Temp)
        currentPage = pages.WinView
        timeRemain = 30
        gameTime.timerRefresh()
    }
    func clearMatrix() {
        question.removeAll()
        questioncheck.removeAll()
        offset.removeAll()
        newPosition.removeAll()
        wordCircleFrame.removeAll()
        wordCircleFrameRecord.removeAll()
        answerCircleFrame.removeAll()
        questionhide.removeAll()
        posCreated.removeAll()
        answerIndexCorrect = 0
        answerCirclehide.removeAll()
        answer.removeAll()
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(currentPage: .constant(pages.GameView), correctNumber: .constant(0), useTime: .constant(""))
            .previewLayout(.fixed(width: 896, height: 414))
    }
}

