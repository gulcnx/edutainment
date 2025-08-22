//
//  ContentView.swift
//  Edutainment
//
//  Created by gülçin çetin on 6.08.2025.
//

import SwiftUI

struct Questions {
    var questions: String
    let correctAnswer: Int
    let answers: [Int]
}

struct ContentView: View {
    @State private var selectedTable = 2
    @State private var questionCount = 2
    
    @State private var score = 0
    
    @State private var feedback = ""
    
    @State private var randomNum = Int.random(in: 2...12)
    
    @State private var currentIndex = 1
    @State private var isGameActive = false
    @State private var reStart = false
    
    @State private var randomAnimals = ["walrus" ,"sloth", "rhino","rabbit", "moose", "monkey", "horse", "gorilla", "buffalo", "elephant", "dog", "penguin","whale" ,"panda" , "narwhal", "cow", "goat" , "hippo","bear" ,"crocodile" ,"parrot","snake","owl" ,"chicken","giraffe","frog", "chick", "pig" , "duck", "zebra"].shuffled()
    
    @State private var i = Int.random(in: 0...30)
    @State private var showingAlert = false
    var body: some View {
                    ZStack{
                        LinearGradient(colors: [.orange , .yellow, .green ], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                        
                        Image(randomAnimals[i])
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                        
                        VStack{
                            if isGameActive{
                                Image(randomAnimals[i])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .transition(.scale)
                                
                                Text("Game Started! Good luck!").bold().padding().background(Color.white.opacity(0.5)).border(.white).clipShape(.capsule)
                            }
                            
                            if !isGameActive {
                                    VStack{
                                        VStack{
                                            Text("Select your multiplication table!")
                                            Stepper("Table of \(selectedTable) Selected", value: $selectedTable, in: 2...12)
                                        }.bold().padding().background(Color.white.opacity(0.7)).border(.white).clipShape(.capsule)
                                        
                                        VStack{
                                            Text("How many questions would you like to solve?")
                                            Stepper("\(questionCount) Many Questions!", value: $questionCount, in: 2...25)
                                        }.bold().padding().background(Color.white.opacity(0.7)).border(.white).clipShape(.capsule)
                                    }
                
                                
                                Button("Start game !") {
                                    withAnimation(){
                                        isGameActive.toggle()
                                    }
                                }
                                .bold()
                                .padding()
                                .foregroundStyle(.white)
                                .background(Color.green)
                                .clipShape(.capsule)
                            }
                            
                            
                            if isGameActive {
                                VStack{
                                    HStack{
                                        Text("\(currentIndex )/\(questionCount)").bold().padding().background(Color.white.opacity(0.7)).border(.white).clipShape(.capsule)
                                        
                                        Text("\(generateQuestion().questions)").bold().padding().background(Color.white.opacity(0.7)).border(.white).clipShape(.capsule)
                                    }.padding()
                                    
                                    ForEach(generateQuestion().answers , id : \.self) {ans in
                                        
                                        Button("\(ans)"){
                                            checkAns(ans)
                                        }
                                    }
                                    .bold()
                                    .padding()
                                    .background(Color.green)
                                    .foregroundStyle(.white)
                                    .clipShape(.capsule)
                                    
                                    Text(feedback)
                                        .bold()
                                        .padding()
                                    
                                }.alert("Game is over. \n Your final score is \(score)/\(questionCount*10)!", isPresented: $showingAlert){
                                    Button("Restart!") {
                                        isGameActive.toggle()
                                        currentIndex = 1
                                        feedback = ""
                                        reStart = false
                                        score = 0
                                        i = Int.random(in: 0...30)
                                    }
                                } message: {
                                    Text("")
                                }
                            }
                        
            }
        }
    }
        func generateQuestion() -> Questions {
            
            let question = "What is equals to \(selectedTable) times \(randomNum)?"
            let correctAnswer = selectedTable * randomNum
            var arrayOfAnswers = [Int]()
            
            arrayOfAnswers.append(correctAnswer)
            
            while arrayOfAnswers.count < 4 {
                let i = Int.random(in: 4...144)
                if !arrayOfAnswers.contains(i){
                    arrayOfAnswers.append(i)
                }
            }
            arrayOfAnswers.shuffle()
            
            return Questions(questions: question , correctAnswer: correctAnswer, answers: arrayOfAnswers)
        }
        
    func checkAns(_ ans :Int) {
        
        if questionCount != currentIndex {
            if ans == (selectedTable * randomNum) {
                score += 10
                feedback = "Congrats! You score is now \(score)"
                currentIndex += 1
                randomNum = Int.random(in: 2...12)
                
            }else {
                feedback = "False. Try again later."
                currentIndex += 1
                randomNum = Int.random(in: 2...12)
                
            }
        }else{
           if ans == (selectedTable * randomNum) {
               score += 10
               feedback = "Congrats! You score is now \(score)"
           }
            showingAlert = true
        }
    }
}

#Preview {
    ContentView()
}
