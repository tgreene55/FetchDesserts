//
//  ContentView.swift
//  FetchProject1
//
//  Created by Taylor Greene on 11/8/23.
//

import SwiftUI

/*
 Initial list view of all desserts
 */
struct ContentView: View {
    @ObservedObject var dessertFetcher: DessertFetcher
    
    var body: some View {
        NavigationStack{
            ZStack{
                if dessertFetcher.isLoading{
                    Text("Loading Desserts...")
                        .foregroundColor(Color.red)
                }else{
                    //All desserts
                    List {
                        ForEach(dessertFetcher.alphabeticalDesserts(), id: \.id) { item  in
                            NavigationLink{
                                DessertDetailView(dessert: item, dessertFetcher: dessertFetcher, id: item.id)
                            }label:{
                                DessertRowView(dessert: item)
                            }
                        }
                    }
                    .navigationTitle("Desserts")
                }
            }
        }
        .foregroundColor(Color.indigo)
        .task {
            await _ = dessertFetcher.fetchAllDesserts()
        }
        .alert("Error fetching data", isPresented: $dessertFetcher.hasError){
            Button{
                Task{
                    await dessertFetcher.fetchAllDesserts()
                }
            }label: {
                Text("Retry")
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var dessertFetcher = DessertFetcher()
        ContentView(dessertFetcher: dessertFetcher)
    }
}






