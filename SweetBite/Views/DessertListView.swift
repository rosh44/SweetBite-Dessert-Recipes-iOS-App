//
//  DessertListView.swift
//  SweetBite
//
//  Created by Roshni Soni on 11/15/23.
//

import SwiftUI

struct DessertListView: View {
    @State private var desserts = [Dessert]()
        private let apiManager = APIManager()

        var body: some View {
            NavigationView {
                List(desserts, id: \.id) { dessert in
                    NavigationLink(destination: DessertDetailView(dessertID: dessert.idMeal)) {
                        HStack {
                            GeometryReader { geo in
                                AsyncImage(url: dessert.strMealThumb) { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width: geo.size.width, height: geo.size.height)
                                } placeholder: {
                                    Color.gray.frame(width: geo.size.width, height: geo.size.height)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .frame(width: 60, height: 60) // Set the frame size of the GeometryReader
                            Text(dessert.strMeal)
                        }
                    }
                }
                .onAppear(perform: loadDesserts)
                .navigationTitle("Desserts")
            }
        }

        private func loadDesserts() {
            print("Inside loadDesserts")
            apiManager.fetchDesserts { fetchedDesserts in
                let sortedDesserts = fetchedDesserts.meals.sorted(by: { $0.strMeal < $1.strMeal })
                desserts = sortedDesserts
            }
        }
}

#Preview {
    DessertListView()
}
