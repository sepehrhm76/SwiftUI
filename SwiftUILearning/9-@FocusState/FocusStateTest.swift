//
//  FocusStateTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/16/25.
//

//@FocusState is a property wrapper in SwiftUI that is used to manage the focus state of focusable views, like TextField, TextEditor, etc.
//It allows you to programmatically control which field is focused or to monitor the focus state of a field.

//Use cases:
//    •    Programmatically focusing a TextField when a view appears
//    •    Dismissing the keyboard or moving between fields in forms
//    •    Managing multiple focusable views in a form

import SwiftUI

struct FocusStateTest: View {
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case name, email
    }

    @State private var name: String = ""
    @State private var email: String = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .focused($focusedField, equals: .name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Email", text: $email)
                .focused($focusedField, equals: .email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Next") {
                            focusedField = .email
                        }
                        Spacer()
                        Button("Previous") {
                            focusedField = .name
                        }
                        Spacer()
                        Button("Done") {
                            focusedField = nil // Dismiss the keyboard
                        }
                    }
                }
        }
        .padding()
        .onAppear {
            focusedField = .name
        }
    }
}

#Preview {
    FocusStateTest()
}
