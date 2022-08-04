//
//  BussinessSection.swift
//  City Sights App
//
//  Created by Krupa Patel on 3/8/2022.
//

import SwiftUI

struct BussinessSection: View {
    
    var title:String
    var busineses:[Business]
    
    var body: some View {
       
        Section (header: SectionHeader(text: title)) {
            
            ForEach(busineses) { business in
                
                NavigationLink {
                    
                    BusinessDetail(business: business)
                } label: {
                
                    BusinessRow(business: business)
                }

            }
    }
}
}
