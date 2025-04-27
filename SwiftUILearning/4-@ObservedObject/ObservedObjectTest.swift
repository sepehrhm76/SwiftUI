//
//  ObservedObjectTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/14/25.
//

//@ObservedObject lets a view observe an external object that conforms to ObservableObject.
//
//The view re-renders automatically when that object publishes changes.

//✅ Used when:
//    •    You want to share state across multiple views
//    •    The data is not view-local
//    •    You’re using view models or data controllers

//🔧 Requires:
//    •    A class conforming to ObservableObject
//    •    Published properties marked with @Published

import Foundation
import SwiftUI

class ObservedObjectTestViewModel: ObservableObject {
    @Published var count: Int = 0
    
    func increment() {
        count += 1
    }
    
    func reset() {
        count = 0
    }
}

struct ObservedObjectTest: View {
    @ObservedObject var viewModel: ObservedObjectTestViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(viewModel.count)")
                .font(.largeTitle)
            
            Button("Increment") {
                viewModel.increment()
            }
            
            Button("Reset") {
                viewModel.reset()
            }
        }
        .padding()
    }
}

#Preview {
    ObservedObjectTest(viewModel: ObservedObjectTestViewModel())
}
