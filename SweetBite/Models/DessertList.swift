//
//  DessertList.swift
//  SweetBite
//
//  Created by Roshni Soni on 11/15/23.
//

import Foundation

struct DessertList: Codable {
    let meals: [Dessert]
}

struct Dessert: Identifiable, Codable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
}
