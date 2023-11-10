//
//  FetchProject1App.swift
//  FetchProject1
//
//  Created by Taylor Greene on 11/8/23.
//

import SwiftUI

@main
struct FetchProject1App: App {
    @StateObject var dessertFetcher = DessertFetcher()
    
    var body: some Scene {
        WindowGroup {
            ContentView(dessertFetcher: dessertFetcher)
               
        }
    }
}

