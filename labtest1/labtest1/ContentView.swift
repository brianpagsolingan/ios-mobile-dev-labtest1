//
//  ContentView.swift
//  labtest1
//
//  Created by Brian Aldrin Pagsolingan on 2026-03-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
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

#Preview {
    ContentView()
}
