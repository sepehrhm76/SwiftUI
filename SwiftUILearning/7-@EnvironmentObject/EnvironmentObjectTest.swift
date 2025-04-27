//
//  EnvironmentObjectTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/16/25.
//

//@EnvironmentObject lets you inject a shared observable object into the SwiftUI environment, and access it anywhere in the view hierarchy — without explicitly passing it down.

//Think of it like global context but still reactive and type-safe.

//•    You update the username in SettingsView
//•    ProfileView automatically updates
//•    No need to manually pass the object around

import SwiftUI

//@main
//struct SwiftUILearningApp: App {
//    @StateObject private var settings = UserSettings()
//
//    var body: some Scene {
//        WindowGroup {
//            EnvironmentObjectTest()
//                .environmentObject(settings) // inject it once!
//        }
//    }
//}

class UserSettings: ObservableObject {
    @Published var username: String = "Type here"
}

struct EnvironmentObjectTest: View {
    var body: some View {
        VStack {
            ProfileView()
            SettingsView()
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        Text("Username: \(settings.username)")
    }
}

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        TextField("Username", text: $settings.username)
    }
}

#Preview {
    EnvironmentObjectTest()
}
