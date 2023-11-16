/**
 * DessertListViewModel.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/15/23.
 *
 * This file is responsible for managing and providing the data required for the Dessert List view.
 * It adheres to the `ObservableObject` protocol, enabling SwiftUI views to observe changes in its state.
 */

import Foundation

class DessertListViewModel: ObservableObject {
    @Published var desserts = [Dessert]()
    @Published var errorMessage: String?

    private let apiManager = APIManager()

    /** Loads the detail of a specific dessert identified by its `dessertID`.
     *  This function calls the `fetchDessertDetail` method of the `apiManager` and updates
     *  the `dessertDetail` and `errorMessage` properties based on the result of the fetch.
     *
     * - Parameter dessertID: A `String` representing the unique identifier of the dessert whose details need to be fetched.
     */
    func loadDesserts() {
        errorMessage = nil
        apiManager.fetchDesserts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedDesserts):
                    self?.desserts = fetchedDesserts.meals.sorted(by: { $0.strMeal < $1.strMeal })
                case .failure:
                    self?.errorMessage = "Oops! Looks like we're having an issue connecting to our dessert library. Please check your internet connection and try again."
                }
            }
        }
    }
}
