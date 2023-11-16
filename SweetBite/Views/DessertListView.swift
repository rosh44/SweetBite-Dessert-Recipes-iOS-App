/**
 * DessertListView.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/15/23.
 *
 * This file defines the `DessertListView` SwiftUI view, which is responsible for displaying a list of desserts to the user.
 * It uses the `APIManager` to fetch dessert data and presents it in a list format.
 * If there is failure in API call which fetches data, an error message is displayed to the user
**/

import SwiftUI

struct DessertListView: View {
    @State private var desserts = [Dessert]()
    @State private var errorMessage: String?
    private let apiManager = APIManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .multilineTextAlignment(.center).padding()
                }
                else{
                    List(desserts, id: \.idMeal) { dessert in
                        NavigationLink(destination: DessertDetailView(dessertID: dessert.idMeal)) {
                            HStack {
                                AsyncImage(url: dessert.strMealThumb) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                } placeholder: {
                                    Color.gray.frame(width: 60, height: 60)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                Text(dessert.strMeal)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear(perform: loadDesserts)
            .navigationBarTitle("SweetBite Desserts", displayMode: .inline)
            
        }
    }
    
    /**
     * This function is responsible for loading dessert data from the API using the `APIManager`.
     * It handles success and failure cases and updates the view accordingly.
     */
    private func loadDesserts() {
        errorMessage = nil
        apiManager.fetchDesserts { result in
            switch result {
            case .success(let fetchedDesserts):
                let sortedDesserts = fetchedDesserts.meals.sorted(by: { $0.strMeal < $1.strMeal })
                desserts = sortedDesserts
            case .failure:
                errorMessage = "Oops! Looks like we're having an issue connecting to our dessert library. Could you please check your internet connection and try again."
            }
        }
    }
}

#Preview {
    DessertListView()
}
