//
//  EnvironmentTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/16/25.
//

//@Environment is a powerful property wrapper in SwiftUI that allows you to access shared system-wide values that are injected into the SwiftUI environment. This is typically used for accessing things like device settings, color schemes, dynamic type sizes, or app-wide settings.
//
//It’s a great way to inject global state without passing it directly through the view hierarchy.
//
//🔍 Common Use Cases:
//    •    Accessing the current color scheme (light/dark mode)
//    •    Getting the current locale (language/country settings)
//    •    Accessing environment values like horizontalSizeClass, verticalSizeClass
//    •    Retrieving app-wide settings or other system states

import SwiftUI

struct EnvironmentTest: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Text("Current color scheme: \(colorScheme == .dark ? "Dark" : "Light")")
                .font(.largeTitle)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
            
            Text("change your device color scheme to \(colorScheme == .dark ? "Light" : "Dark") to see the effect")
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(10)
        .padding()
    }
}

//More Examples of Common @Environment Values:
//    1.    @Environment(\.sizeCategory): Accesses the dynamic type size.
//    2.    @Environment(\.locale): Retrieves the current locale.
//    3.    @Environment(\.horizontalSizeClass): Accesses the horizontal size class (e.g., compact vs regular).
//    4.    @Environment(\.presentationMode): Used to dismiss views programmatically.

#Preview {
    EnvironmentTest()
}
