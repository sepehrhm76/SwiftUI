//
//  StateObjectTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/14/25.
//

//@StateObject is used to own an ObservableObject instance inside a view.
//SwiftUI will create it once, and keep it alive for the lifetime of the view.

//🔍 Why it exists:
//
//@ObservedObject assumes the object is passed in, and doesn’t manage its lifecycle.
//If you accidentally create a new ObservableObject every time, it will reset on every render.
//
//@StateObject solves this by making the view the owner of the model.

//Use @StateObject when:
//The view creates and owns the model
//You want the model to persist across renders
//You want to initialize it just once


import Foundation
import SwiftUI

class StateObjectTestViewModel: ObservableObject {
    @Published var count = 0

    func increment() {
        count += 1
    }
}

struct StateObjectTest: View {
    @StateObject private var viewModel = StateObjectTestViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(viewModel.count)")
                .font(.largeTitle)

            Button("Increment") {
                viewModel.increment()
            }
        }
        .padding()
    }
}

#Preview {
    StateObjectTest()
}
