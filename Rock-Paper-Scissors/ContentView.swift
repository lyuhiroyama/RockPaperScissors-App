//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Lyu Hiroyama on 2023/08/24.
//

import SwiftUI

struct ContentView: View {
    
    let appArrayRSP = ["✂️", "🗿", "🧻"]
    let winArrayRSP = ["🗿", "🧻", "✂️"]
    @State private var intChoice = Int.random(in: 0..<3)
    @State private var appRSPchoice = "🗿"
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var alertText = ""
    @State private var isPressed = false
    
    @State private var numOfRounds = 0
    @State private var gameOverText = ""
    @State private var isGameOver = false
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(colors: [.indigo, .blue], center: .center, startRadius: 200, endRadius: 300)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Obey the AI!")
                    .font(.largeTitle.weight(.bold))
                
                Spacer()
                VStack(spacing: 20) {
                    HStack {
                        Text("AI's choice: ")
                            .font(.title)
                        Text(appArrayRSP[intChoice])
                            .font(.system(size: 66))
                    }
                    Text(shouldWin ? "You gotta win bro" : "You gotta lose broski")
                        .font(.title)
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<3) { number in
                        Button() {
                            buttonTapped(number)
                        } label: {
                            Text(winArrayRSP[number])
                                .font(.system(size:90))
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Your Score: \(score)")
                        .font(.title)
                    Text("Tries remaining: \(10 - numOfRounds)")
                        .font(.title)
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            .alert(alertText, isPresented: $isPressed) {
                Button("Cool bro") {
                    nextRound()
                    gameOverText = numOfRounds == 10 ? "Final Score: \(score)/10" : ""
                    isGameOver = numOfRounds == 10 ? true : false
                }
            }
            .alert(gameOverText, isPresented: $isGameOver) {
                Button(score == 10 ? "I wanna play again bro" : "My bad bro") {
                    reset()
                }
            } message: {
                Text(score == 10 ? "Good game bro" : "You kinda suck bro")
            } //End of body/ZStack/VStack
            .padding()
        } //End of body/ZStack
    }
    
    // End of body property
    
    func buttonTapped(_ number: Int) {
        
        numOfRounds += 1
        
        if shouldWin {
            alertText = intChoice == number ? "You obedient bro" : "Why u no listen bro"
            score += intChoice == number ? 1 : -1
        } else {
            alertText = intChoice != number ? "You obedient bro" : "Why u no listen bro"
            score += intChoice != number ? 1 : -1
        }
        isPressed = true
    }
    
    func nextRound() {
        intChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func reset() {
        score = 0
        numOfRounds = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
