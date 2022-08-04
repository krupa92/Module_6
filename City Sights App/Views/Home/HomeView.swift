//
//  HomeView.swift
//  City Sights App
//
//  Created by Krupa Patel on 3/8/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var isMapShowing = false
    
    var body: some View {
     
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                
                if !isMapShowing {
                    // show list
                    
                    VStack {
                        
                        HStack {
                            
                            Image(systemName: "location")
                            Text("Sun Francisco")
                            Spacer()
                            Text("Swich to map view")
                        }
                        Divider()
                        
                        ListView()
                    }.navigationBarHidden(true)
                    .padding([.horizontal,.top])
                    
                } else {
                    
                    //show map
                }
            }
            
            
        } else {
            
            ProgressView()
        }
      
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
