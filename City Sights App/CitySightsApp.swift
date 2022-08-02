//
//  CitySightsApp.swift
//  City Sights App
//
//  Created by Krupa Patel on 2/8/2022.
//

import SwiftUI


@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LunchView().environmentObject(ContentModel())
        }
    }
}
