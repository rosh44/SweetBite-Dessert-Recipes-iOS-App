/**
 * DessertDetailViewModel.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/15/23.
 *
 * This file is responsible for managing and providing the data required for the Dessert Detail view.
 * It adheres to the `ObservableObject` protocol, enabling SwiftUI views to observe changes in its state.
 */

import Foundation

class DessertDetailViewModel: ObservableObject {
    @Published var dessertDetail: DessertDetail?
    @Published var errorMessage: String?

    private let apiManager = APIManager()
    
    /**
     * Loads the list of desserts from the API.
     * This function calls the `fetchDesserts` method of `apiManager` and updates
     * the `desserts` and `errorMessage` properties based on the result of the fetch.
     */
    func loadDessertDetail(dessertID: String) {
        apiManager.fetchDessertDetail(dessertID: dessertID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedDessertDetail):
                    self?.dessertDetail = fetchedDessertDetail
                case .failure:
                    self?.errorMessage = "Oops! Looks like we're having an issue connecting to our dessert recipe library. Please check your internet connection and try again."
                }
            }
        }
    }
}
