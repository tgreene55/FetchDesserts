//
//  LoadData.swift
//  FetchProject1
//
//  Created by Taylor Greene on 11/8/23.
//

import Foundation

/*
 Fetch dessert data, handles both list of all, and specific dessert
 */
class DessertFetcher: ObservableObject {
    @Published var desserts = [Dessert]()
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    
    //Sort the desserts alphabetically
    func alphabeticalDesserts() ->  [Dessert] {
        return desserts.sorted()
    }
    
    /*
     Full Dessert list
     */
    @MainActor
    func fetchAllDesserts(id: String? = nil) async -> [Dessert]?  {
        do{
            self.isLoading = true
            if let result = try await APIFetchData().fetch(DessertResponse.self){
                self.desserts =  result.meals
                self.isLoading = false
                return result.meals
            }
        }catch {
            fatalError("Could not load desserts")
        }
        self.isLoading = false
        return nil
    }
    
    /*
     Single dessert details
     */
    @MainActor
    func fetchDessertDetails(id: String) async -> Dessert?  {
        var dessert: Dessert? = nil
        do{
            self.isLoading = true
            if let result = try await APIFetchData().fetchDessertDetails(DessertResponse.self, id: id){
                isLoading = false
                dessert = result.meals.first
                
            }
        }catch {
            fatalError("Could not load desserts")
        }
        self.isLoading = false
        return dessert
    }
}

/*
 Pull out API call to fetch data
 */
struct APIFetchData {
    let urlAllDesserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let urlDessDetails = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetch<T: Decodable>(_ type: T.Type)  async throws -> T? {
        ///get all desserts, you'll sort later
        guard let urlDesserts = URL(string: urlAllDesserts) else{
            fatalError("Couldn't find URL.")
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: urlDesserts)
            if let response = response as? HTTPURLResponse{
                if  !(response.statusCode >= 200 && response.statusCode <= 300){
                    fatalError("Error loading data.")
                }
            }
            let result = try? JSONDecoder().decode(type, from: data)
            return result
        } catch{
            fatalError("Error loading data")
        }
    }
    
    func fetchDessertDetails<T: Decodable>(_ type: T.Type, id: String)  async throws -> T? {
        ///add ID on url to search specific dessert
        guard let urlDessertDetails = URL(string: urlDessDetails + id) else{
            fatalError("Couldn't find URL.")
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: urlDessertDetails)
            if let response = response as? HTTPURLResponse{
                if  !(response.statusCode >= 200 && response.statusCode <= 300){
                    fatalError("Error loading data.")
                }
            }
            let result = try? JSONDecoder().decode(type, from: data)
            return result
        } catch{
            fatalError("Error loading data")
        }
    }
}
