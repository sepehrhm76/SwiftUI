//
//  GestureStateTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/16/25.
//

//@GestureState is a special property wrapper that works with gesture interactions. It is used to track temporary gesture state (e.g., drag, long press, tap) during the gesture lifecycle.
//
//Key points:
//    •    Tracks changes during a gesture (like drag distance, rotation, etc.)
//    •    Automatically resets to its initial state when the gesture ends
//    •    Doesn’t affect the main view state — it’s temporary and only relevant while the gesture is active

import SwiftUI

struct GestureStateTest: View {
    // Track the drag's position during the gesture
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        let dragGesture = DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation // updates dragOffset with translation
            }

        return Circle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .offset(dragOffset)  // apply the drag offset
            .gesture(dragGesture)
    }
}

#Preview {
    GestureStateTest()
}
