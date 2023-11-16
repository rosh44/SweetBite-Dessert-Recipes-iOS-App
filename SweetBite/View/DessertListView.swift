/**
 * DessertListView.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/15/23.
 *
 * This file defines the `DessertListView` SwiftUI view, which is responsible for displaying a list of desserts to the user.
 * It uses the `DessertListViewModel` to manage and present the data.
 *  In case of any errors during data fetching, an error message is displayed.
**/

import SwiftUI

struct DessertListView: View {
    @StateObject private var viewModel = DessertListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .multilineTextAlignment(.center).padding()
                }
                else{
                    List(viewModel.desserts, id: \.idMeal) { dessert in
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
            .onAppear(perform: viewModel.loadDesserts)
            .navigationBarTitle("SweetBite Desserts", displayMode: .inline)
            
        }
    }
    
}

#Preview {
    DessertListView()
}
