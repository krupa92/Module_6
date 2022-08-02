//
//  ContentModel.swift
//  City Sights App
//
//  Created by Krupa Patel on 2/8/2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate,ObservableObject {
    
    var locationManager = CLLocationManager()
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        
        // init method of NSObject
        super.init()
        
        // set contant model as delegate of locationmanager
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first
        
        if userLocation != nil {
            
            
            locationManager.stopUpdatingLocation()
            
            // if we have codinates of location send it to Yelp API
            getBussiness(category: Constants.sightsKey, location: userLocation!)
            getBussiness(category: Constants.restaurantsKey, location: userLocation!)
           
            
        }
       
    }
    
    func getBussiness(category:String, location:CLLocation) {
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
        
        urlComponents?.queryItems = [
        
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(SearchBusiness.self, from: data!)
                        
                        DispatchQueue.main.async {
                            
//                            if category == Constants.sightsKey {
//
//                                self.sights = result.businesses
//
//                            } else if category == Constants.restaurantsKey {
//
//                                self.restaurants = result.businesses
//                            }
                            
                            switch category {
                                
                            case Constants.sightsKey:
                                
                                self.sights = result.businesses
                                
                            case Constants.restaurantsKey:
                                
                                self.restaurants = result.businesses
                                
                            default:
                                break
                            }
                            
                        }
                        
                        
                    } catch {
                        
                        print(error)
                    }
                }
            }
            
            dataTask.resume()
        }
    }
}
