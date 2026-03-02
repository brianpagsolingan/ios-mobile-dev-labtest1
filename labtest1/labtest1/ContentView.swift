//
//  ContentView.swift
//  labtest1
//
//  Created by Brian Aldrin Pagsolingan on 2026-03-02.
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...100)
    @State private var answerState: Answer = .none
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var attemptCount: Int = 0
    @State private var showSummary: Bool = false
    @State private var timeRemaining: Int = 5
    @State private var timer: Timer? = nil
    @State private var answered: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            // timer
            HStack{
                Spacer()
                Text("Timer: \(timeRemaining)")
                    .font(.system(size: 18, weight:.semibold, design: .rounded))
                    .padding(.trailing, 24)
                    .padding(.top, 16)
            }
            Spacer()
            
        }
        .padding()
    }
    
    private func handleAnswer(userSaysPrime: Bool) {
        guard !answered else { return }
        answered = true
        timer?.invalidate()
        
        let correct = isPrime(currentNumber) == userSaysPrime
        withAnimation{
            answerState = correct ? .correct : .wrong
        }
        if correct {correctCount += 1} else {wrongCount += 1}
        
        attemptCount += 1
        
        checkMileStone()
        
    }
    
    private func checkMileStone() {
        // show score after 10 answers
        if attemptCount % 10 == 0 {
            showSummary = true
        }
    }
    
    private func nextNumber(){
        withAnimation{
            answerState = .none
        }
        answered = false
        currentNumber = Int.random(in: 1...100)
        timeRemaining = 5
        startTimer()
    }
    
    private func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            _ in if timeRemaining > 1{
                timeRemaining -= 1
            }else{
                // ran out of time
                timer?.invalidate()
                answered = true
                withAnimation{
                    answerState = .wrong
                }
                wrongCount += 1
                attemptCount += 1
                checkMileStone()
            }
        }
        
    }
}

// Rpime number checker

func isPrime(_ number: Int) -> Bool {
    guard number > 1 else { return false }
    for i in 2..<number {
        if number.isMultiple(of: i) {
            return false
        }
    }
    return true
}

enum Answer{
    case none, correct, wrong
}

#Preview {
    ContentView()
}
