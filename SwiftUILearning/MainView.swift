//
//  MainView.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/27/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var settings = UserSettings()
    var body: some View {
        NavigationView {
            List {
                NavigationLink("@AppStorage Example", destination: AppStorageTest())
                NavigationLink("@State Example", destination: StateTest())
                NavigationLink("@Binding Example", destination: BindingTest())
                NavigationLink("@ObservedObject Example", destination: ObservedObjectTest(viewModel: ObservedObjectTestViewModel()))
                NavigationLink("@StateObject Example", destination: StateObjectTest())
                NavigationLink("@StateObject Vs @ObservedObject Example", destination: StateObjectVSObservedObject())
                NavigationLink("@EnvironmentObject Example", destination: EnvironmentObjectTest().environmentObject(settings))
            }
            .navigationTitle("SwiftUI Learning")
        }
    }
}

#Preview {
    MainView()
}
