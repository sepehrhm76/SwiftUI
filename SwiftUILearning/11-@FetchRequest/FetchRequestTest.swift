//
//  FetchRequestTest.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/17/25.
//

//@FetchRequest is a property wrapper used in SwiftUI to fetch data from Core Data and bind it directly to a view. It makes it easy to interact with Core Data without having to manually handle the NSFetchRequest or the context updates.
//
//You use @FetchRequest when:
//    •    You want to fetch and display data from Core Data in a SwiftUI view.
//    •    Automatically updates the UI when the Core Data data changes.

import SwiftUI

@main
struct SwiftUILearningApp: App {
    var body: some Scene {
        WindowGroup {
            FetchRequestTest()
//                .environment(<#T##object: (Observable & AnyObject)?##(Observable & AnyObject)?#>)
        }
    }
}

struct FetchRequestTest: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FetchRequestTest()
}
