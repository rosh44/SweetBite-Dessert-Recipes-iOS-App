/**
 * APIManager.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/15/23.
 *
 * This file defines the `APIManager` class, which is responsible for making API requests
 * to fetch dessert data and dessert details from an external API.
*/

import Foundation

class APIManager {
    
    /**
     * Fetches a list of desserts from the external API.
     *
     * - Parameter completion: A closure that is called when the API request is complete.
     *   It returns a `Result` type containing either a `DessertList` on success or an `Error` on failure.
     */
    func fetchDesserts(completion: @escaping (Result<DessertList, Error>) -> Void) {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("fetchDesserts >> Error:", error)
                    completion(.failure(error))
                }
            }
            else if let data = data {
                do {
                    let dessertList = try JSONDecoder().decode(DessertList.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(dessertList))
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("fetchDesserts >> Error:", error)
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
        
    }
    
    /**
     * Fetches details of a dessert by its ID from the external API.
     *
     * - Parameter dessertID: The ID of the dessert to fetch details for.
     * - Parameter completion: A closure that is called when the API request is complete.
     *   It returns a `Result` type containing either a `DessertDetail` on success or an `Error` on failure.
     */
    func fetchDessertDetail(dessertID: String, completion: @escaping (Result<DessertDetail, Error>) -> Void) {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessertID)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("fetchDessertDetail >> Error:", error)
                    completion(.failure(error))
                }
            }
            else if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let dessertDetailResponse = try decoder.decode([String: [DessertDetail]].self, from: data)
                    
                    if let dessertDetail = dessertDetailResponse["meals"]?.first {
                        DispatchQueue.main.async {
                            completion(.success(dessertDetail))
                        }
                    }
                } catch {
                    print("fetchDessertDetail >> Error:", error)
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
            }
        }.resume()
    }
}
