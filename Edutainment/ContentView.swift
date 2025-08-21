//
//  ContentView.swift
//  Edutainment
//
//  Created by gülçin çetin on 6.08.2025.
//

import SwiftUI

struct Questions {
    let question: String
    let correctAnswer: Int
    let answers: [Int]
}

struct ContentView: View {
    @State private var selectedTable = 2
    @State private var questionCount = 2
    
    @State private var score = 0
    
    @State private var feedback = ""
    
    
   @State private var randomNum = Int.random(in: 2...12)
    
    @State private var currentQuestion = 1
    var body: some View {
        VStack{
            Text("Hi kiddo!").padding()
            Text("Select your multiplication table!")
            Stepper("Table of \(selectedTable) Selected", value: $selectedTable, in: 2...12).padding()
            
            Text("How many questions would you like to solve?")
            Stepper("\(questionCount) Many Questions!", value: $questionCount, in: 2...25).padding()

            HStack{
                Text("\(currentQuestion))")
                Text("\(generateQuestion().question)")
            }.padding()

            
            ForEach(generateQuestion().answers , id : \.self) {ans in
                Button("-> \(ans)"){
                  checkAns(ans)
            }
        }
    }
        Text(feedback)
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
        
        return Questions(question: question, correctAnswer: correctAnswer, answers: arrayOfAnswers)
    }
    
    func checkAns(_ ans :Int) {
        
        if questionCount > currentQuestion {
            
            if ans == (selectedTable * randomNum) {
                score += 10
                feedback = "Congrats! You score is now \(score)"
                currentQuestion += 1
                randomNum = Int.random(in: 2...12)
            }else {
                feedback = "False. Try again later."
                currentQuestion += 1
                randomNum = Int.random(in: 2...12)
            }
        }else{
            feedback = "Game is over. Total score is \(score) in \(questionCount) questions!"
        }
    }
}

#Preview {
    ContentView()
}
