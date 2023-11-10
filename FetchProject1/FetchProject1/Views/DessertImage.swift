//
//  DessertImage.swift
//  FetchProject1
//
//  Created by Taylor Greene on 11/8/23.
//

import SwiftUI

/*
 Thumb image for small list tile
 */
struct DessertImageSmall: View{
    var dessertImage: String
    var body: some View{
        AsyncImage(url: URL(string: dessertImage)) { imageLoading in
            if let image = imageLoading.image {
                image.resizable()
                    .clipShape(Circle())
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
            } else if imageLoading.error != nil {
                VStack {
                    Text("No")
                    Text("Image")
                }
            } else {
                ProgressView()
            }
        }
    }
}

/*
 Larger image for detail view
 */
struct DessertImageLarge: View{
    var dessertImage: String
    var body: some View{
        AsyncImage(url: URL(string: dessertImage)) { imageLoading in
            if let image = imageLoading.image {
                image.resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(8)
            } else if imageLoading.error != nil {
                VStack {
                    Text("No")
                    Text("Image")
                }
            } else {
                ProgressView()
            }
        }
    }
}
