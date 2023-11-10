//
//  DessertDetailView.swift
//  FetchProject1
//
//  Created by Taylor Greene on 11/8/23.
//


import SwiftUI

/*
 Full page detail view of one dessert
 */
struct DessertDetailView: View {
    
    @State var dessert: Dessert?
    var dessertFetcher: DessertFetcher
    let id: String
    
    var body: some View {
        if dessertFetcher.isLoading{
            Text("Loading Dessert...")
                .foregroundColor(Color.red)
        }else{
            ScrollView {
                VStack(){
                    Text(dessert?.strMeal ?? "Dessert name not available")
                        .font(.title.weight(.light ))
                        .foregroundColor(Color.cyan)
                    VStack{
                        if let dessertImage = dessert?.strMealThumb {
                            DessertImageLarge(dessertImage: dessertImage)
                                .padding([.bottom], 20)
                        }
                    }
                    Divider()
                    Text("Ingredients")
                        .font(.title2)
                        .foregroundColor(Color.blue)
                        .padding([.bottom], 10)
                    
                    VStack(alignment: .leading) {
                        ForEach(dessert?.ingredandmeas ?? [], id: \.self) { item  in
                            Text(item)
                                .foregroundColor(Color.primary)
                            
                            
                        }.listRowInsets(EdgeInsets() )
                    }
                    ScrollView() {
                        VStack {
                            Divider()
                            Text("Instructions")
                                .font(.title2)
                                .foregroundColor(Color.blue)
                                .padding([.bottom], 10)
                            
                            Text(dessert?.strInstructions ?? "Instructions not available")
                                .font(.callout)
                                .fontWeight(.light)
                                .foregroundColor(Color.primary)
                            
                        }
                    }
                }
                .alignmentGuide(.leading) { d in d[.leading] }
                .task {
                    await self.dessert = dessertFetcher.fetchDessertDetails(id: self.id)
                }
                .padding()
            }
            
        }
    }
}
