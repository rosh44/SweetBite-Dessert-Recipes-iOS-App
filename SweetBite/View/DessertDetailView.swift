/**
* DessertDetailView.swift
* SweetBite
*
* Created by Roshni Soni on 11/15/23.
*
* This file defines the `DessertDetailView` SwiftUI view, which is responsible for displaying details of a dessert.
* It uses the `DessertDetailViewModel` to manage and present the data.
* In case of any errors during data fetching, an error message is displayed.
*/

import SwiftUI

struct DessertDetailView: View {
    let dessertID: String
    @StateObject private var viewModel = DessertDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .multilineTextAlignment(.center).padding()
                }else
                if let dessertDetail = viewModel.dessertDetail {
                    
                    AsyncImage(url: dessertDetail.strMealThumb) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray.aspectRatio(contentMode: .fit)
                    }
                    
                    Text(dessertDetail.strMeal)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Instructions:")
                        .font(.headline)
                    
                    Text(dessertDetail.strInstructions)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Divider()
                    
                    Text("Ingredients:")
                        .font(.headline)
                    
                    // Dynamic view for ingredients and measures
                    ForEach(1..<21, id: \.self) { index in
                        if let ingredient = getIngredient(for: index),
                            let measure = getMeasure(for: index),
                            !ingredient.isEmpty {
                            Text("\(ingredient): \(measure)")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                } else {
                    Text("Loading...\nIf this is taking too long, check your connection and try again")
                        .multilineTextAlignment(.center).padding()
                }
            }
            .padding([.horizontal, .bottom])
        }
        .onAppear{
            viewModel.loadDessertDetail(dessertID: dessertID)
        }
        .navigationBarTitle("Dessert Recipe", displayMode: .inline)
    }
    
    /**
     * Helper function to get the ingredient at a given index from the dessert detail.
     * - Parameter index: The index of the ingredient.
     * - Returns: The ingredient at the specified index.
     */
    private func getIngredient(for index: Int) -> String? {
        guard let detail = viewModel.dessertDetail else { return nil }
        
        switch index {
            case 1: return detail.strIngredient1
            case 2: return detail.strIngredient2
            case 3: return detail.strIngredient3
            case 4: return detail.strIngredient4
            case 5: return detail.strIngredient5
            case 6: return detail.strIngredient6
            case 7: return detail.strIngredient7
            case 8: return detail.strIngredient8
            case 9: return detail.strIngredient9
            case 10: return detail.strIngredient10
            case 11: return detail.strIngredient11
            case 12: return detail.strIngredient12
            case 13: return detail.strIngredient13
            case 14: return detail.strIngredient14
            case 15: return detail.strIngredient15
            case 16: return detail.strIngredient16
            case 17: return detail.strIngredient17
            case 18: return detail.strIngredient18
            case 19: return detail.strIngredient19
            case 20: return detail.strIngredient20
            default: return nil
        }
    }

    /**
     * Helper function to get the measure at a given index from the dessert detail.
     * - Parameter index: The index of the measure.
     * - Returns: The measure at the specified index.
     */
    private func getMeasure(for index: Int) -> String? {
        guard let detail = viewModel.dessertDetail else { return nil }

        switch index {
            case 1: return detail.strMeasure1
            case 2: return detail.strMeasure2
            case 3: return detail.strMeasure3
            case 4: return detail.strMeasure4
            case 5: return detail.strMeasure5
            case 6: return detail.strMeasure6
            case 7: return detail.strMeasure7
            case 8: return detail.strMeasure8
            case 9: return detail.strMeasure9
            case 10: return detail.strMeasure10
            case 11: return detail.strMeasure11
            case 12: return detail.strMeasure12
            case 13: return detail.strMeasure13
            case 14: return detail.strMeasure14
            case 15: return detail.strMeasure15
            case 16: return detail.strMeasure16
            case 17: return detail.strMeasure17
            case 18: return detail.strMeasure18
            case 19: return detail.strMeasure19
            case 20: return detail.strMeasure20
            default: return nil
        }
    }
}

#Preview {
    DessertDetailView(dessertID: "123")
}
