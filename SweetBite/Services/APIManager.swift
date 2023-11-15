//
//  APIManager.swift
//  SweetBite
//
//  Created by Roshni Soni on 11/15/23.
//

import Foundation

class APIManager {
    func fetchDesserts(completion: @escaping (DessertList) -> Void) {
        print("Inside fetchDesserts")
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("fetchDessertDetail : empty data")
                return
            }
            print("fetchDessertDetail data: ", data)
            if let dessertList = try? JSONDecoder().decode(DessertList.self, from: data) {
                print("fetchDessertDetail dessertList: ", dessertList)
                DispatchQueue.main.async {
                    completion(dessertList)
                }
            }else {
                print("Decoding failed")
            }
        }.resume()
    }

    func fetchDessertDetail(dessertID: String, completion: @escaping (DessertDetail) -> Void) {
        print("Inside fetchDessertDetail")
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessertID)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            if let dessertDetailResponse = try? JSONDecoder().decode([String: [DessertDetail]].self, from: data),
                       let dessertDetail = dessertDetailResponse["meals"]?.first {
                        DispatchQueue.main.async {
                            completion(dessertDetail)
                        }
                    }
        }.resume()
    }
}
