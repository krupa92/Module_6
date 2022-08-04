//
//  ListView.swift
//  City Sights App
//
//  Created by Krupa Patel on 3/8/2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        ScrollView (showsIndicators: false){
            
            LazyVStack(alignment:.leading , pinnedViews: [.sectionHeaders]) {
                
                BussinessSection(title: Constants.restaurantsKey, busineses: model.restaurants)
               
                BussinessSection(title: Constants.sightsKey, busineses: model.sights)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
