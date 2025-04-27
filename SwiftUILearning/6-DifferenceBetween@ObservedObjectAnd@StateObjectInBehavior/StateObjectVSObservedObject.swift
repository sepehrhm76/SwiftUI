//
//  StateObjectVSObservedObject.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/15/25.
//

import Foundation
import SwiftUI

class StateObjectVSObservedObjectViewModel: ObservableObject {
    @Published var count = 0
    
    func increment() {
        count += 1
    }
    
    deinit {
        TopAlert.shared.show(type: .warning, message: "🧨 CounterViewModel deinitialized")
    }
}

struct StateObjectVSObservedObject: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("❌ Bad @ObservedObject")
                    .font(.headline)
                BadObservedObjectWrapper()
            }
            Divider()
            VStack {
                Text("✅ Good @StateObject + @ObservedObject")
                    .font(.headline)
                GoodObservedObjectWrapper()
            }
        }
        .padding()
    }
}

struct StateObjectCounterView: View {
    @StateObject private var viewModel = StateObjectVSObservedObjectViewModel()

    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Increment") {
                viewModel.increment()
            }
        }
        .padding()
    }
}

struct BadObservedObjectWrapper: View {
    var body: some View {
        ObservedObjectCounterView(viewModel: StateObjectVSObservedObjectViewModel())
    }
}

struct GoodObservedObjectWrapper: View {
    @StateObject private var viewModel = StateObjectVSObservedObjectViewModel()

    var body: some View {
        ObservedObjectCounterView(viewModel: viewModel)
    }
}

struct ObservedObjectCounterView: View {
    @ObservedObject var viewModel: StateObjectVSObservedObjectViewModel

    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Increment") {
                viewModel.increment()
            }
        }
        .padding()
    }
}

#Preview {
    StateObjectVSObservedObject()
}
