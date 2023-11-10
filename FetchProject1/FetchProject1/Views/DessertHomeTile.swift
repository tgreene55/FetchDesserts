//
//  DessertDetail.swift
//  FetchProject1
//
//  Created by Taylor Greene on 11/8/23.
//

import SwiftUI

/*
 Row in list of all desserts
 */
struct DessertRowView: View {
    let dessert: Dessert
    
    var body: some View {
        HStack(spacing: 5){
            if let dessertImage = dessert.strMealThumb {
                DessertImageSmall(dessertImage: dessertImage)
            }
            Text(dessert.strMeal)
                .font(.title2.weight(.light))
            
        }
    }
}



