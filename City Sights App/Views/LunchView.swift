//
//  ContentView.swift
//  City Sights App
//
//  Created by Krupa Patel on 2/8/2022.
//

import SwiftUI
import CoreLocation

struct LunchView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        if model.authorizationState == .notDetermined {
            
            // if undeterming show on boading
            
        } else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            
            // showhomeview
            
            HomeView()
            
        } else {
            
            //show denied view
        }
      
    }
}

struct LunchView_Previews: PreviewProvider {
    static var previews: some View {
        LunchView()
    }
}
