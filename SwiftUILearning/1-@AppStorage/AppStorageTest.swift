//
//  AppStorageTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/13/25.
//

//@AppStorage is a SwiftUI property wrapper that lets you read and write values directly to UserDefaults — but in a SwiftUI-friendly way. It’s perfect for persisting simple user preferences like settings, toggles, usernames, etc.

//@AppStorage("key") var value: Type

import SwiftUI

struct AppStorageTest: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dark Mode is \(isDarkMode ? "ON" : "OFF")")
                .font(.headline)

            Toggle("Enable Dark Mode", isOn: $isDarkMode)
                .padding()
        }
        .padding()
    }
}

#Preview {
    AppStorageTest()
}
