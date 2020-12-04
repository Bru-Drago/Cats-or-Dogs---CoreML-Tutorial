//
//  Cats_or_DogsApp.swift
//  Cats or Dogs
//
//  Created by Bruna Fernanda Drago on 03/12/20.
//

import SwiftUI

@main
struct Cats_or_DogsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: AnimalModel())
        }
    }
}
