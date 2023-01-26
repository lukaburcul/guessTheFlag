//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by user on 17.01.2023..
//

import SwiftUI
  


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showAlert = false
    @State private var scoreCounter : Int = 0
    @State private var scoreMsg = ""
    @State private var gameDuration : Int = 8
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white,.mint,.cyan,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 35){
                VStack(spacing: 5){Text("Tap the flag of")
                        .font(.subheadline)
                        .bold()
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                
                 ForEach(0..<3){number in
                    Button{
                        checkAnswear(number)
                    } label: {
                        Image(countries[number])
                            .cornerRadius(10)
                            .shadow(color: .black , radius: 4)
                    }
                 }
                
                Text("Trys left: \(gameDuration)")
                    .font(.callout)
                    .bold()
                    
                    
            }.alert(scoreMsg, isPresented: $showAlert){
                Button("Continue", action: nextQuestion)
            } message : {
                
                if gameDuration == 0 {
                   Text("Your score was: \(scoreCounter), game will RESET NOW!")
               
                } else {
                    Text("Your Score: \(scoreCounter)")
                        .bold()
                }
                
            }
        }
        
    }
    
    
    func checkAnswear (_ number: Int){
        gameDuration -= 1
        if number == correctAnswer{
            scoreMsg = "That was correct!"
            self.scoreCounter += 1
            
        }
        else{
            scoreMsg = "Uups, that was incorrect!"
        }
        
        showAlert = true
    }
    
    
    func nextQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        if gameDuration == 0{
            gameDuration = 8
            scoreCounter = 0
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
