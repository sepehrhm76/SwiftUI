//
//  StateTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/14/25.
//

//@State is used to declare local, view-owned, mutable state in SwiftUI.
//It tells SwiftUI:
//
//“Hey, this value might change, and when it does, the view should re-render.”
//
//Use it when:
//    •    The data is owned by the view
//    •    You don’t need to pass it around
//    •    You want SwiftUI to track changes and refresh the view

import SwiftUI

struct StateTest: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.largeTitle)

            Button("Increase") {
                count += 1
            }

            Button("Reset") {
                count = 0
            }
        }
        .padding()
    }
}
#Preview {
    StateTest()
}
