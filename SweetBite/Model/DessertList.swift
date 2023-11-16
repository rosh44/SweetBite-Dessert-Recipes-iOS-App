/**
 * DessertListl.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/15/23.
 *
 * This file defines the data model for inidividual Dessert item and the dessert list.
**/

import Foundation

/** A struct representing a list of desserts */
struct DessertList: Codable {
    let meals: [Dessert]
}

/** A struct representing a dessert item */
struct Dessert: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
}
