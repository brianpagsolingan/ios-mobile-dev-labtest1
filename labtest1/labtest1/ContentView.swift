//
//  ContentView.swift
//  labtest1
//
//  Created by Brian Aldrin Pagsolingan on 2026-03-02.
//

import SwiftUI

struct ContentView: View {
    private var currentNumber: Int = Int.random(in: 1...100)
    @State private var answerState: Answer = .none
    @State private var correctCount: Int = 0
    private var wrongCount: Int = 0
    private var attemptCount: Int = 0
    private var showSummary: Bool = false
    private var timeRemaining: Int = 5
    private var timer: Timer? = nil
    @State private var answered: Bool = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
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
        if correct {correctCount += 1}
        
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
