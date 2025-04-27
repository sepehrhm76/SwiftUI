//
//  BindingTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/14/25.
//

//@Binding creates a two-way connection to a state value that is owned by a parent view.
//
//It allows a child view to read and write to a piece of state defined elsewhere — without owning it.

//You use the $ prefix when you want to pass a binding, not just the value.

//You’re saying:
//
//“Hey child view, here’s a binding to isOn, so you can modify it.”

//•    @State var counter = 0 — this is like owning a variable
//•    $counter — this is like handing someone a pointer to your variable, so they can change it directly

import SwiftUI

struct BindingTest: View {
    @State private var selectedColor: Color = .blue

    var body: some View {
        VStack(spacing: 20) {
            Text("Selected Color")
                .font(.headline)
                .foregroundColor(selectedColor)

            Circle()
                .fill(selectedColor)
                .frame(width: 100, height: 100)

            CustomColorPicker(selectedColor: $selectedColor)
        }
        .padding()
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color

    var body: some View {
        ColorPicker("Pick a Color", selection: $selectedColor)
            .padding()
    }
}

#Preview {
    BindingTest()
}
