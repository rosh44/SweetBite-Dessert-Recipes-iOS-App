/**
 * ContentView.swift
 * SweetBite
 *
 * Created by Roshni Soni on 11/14/23.
 *
 *  This is the main view of the SweetBite app. It serves as the entry point for the app's user interface.
 *  The `body` property of this view contains the `DessertListView`, which displays a list of desserts to the user.
**/

import SwiftUI

struct ContentView: View {
    var body: some View {
        DessertListView()
    }
}

#Preview {
    ContentView()
}
