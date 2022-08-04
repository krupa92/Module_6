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
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    override init() {
        
        // init method of NSObject
        super.init()
        
        // set contant model as delegate of locationmanager
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        authorizationState = locationManager.authorizationStatus
        
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
        
        var urlComponents = URLComponents(string:Constants.apiUrl)
        
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
                        
                        // sort bussiness
                        
                        var bussiness = result.businesses
                        bussiness.sort { b1, b2 in
                            
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        for b in bussiness {
                            
                            b.getImageData()
                        }
                        
                       
                        
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
                                
                                self.sights = bussiness
                                
                            case Constants.restaurantsKey:
                                
                                self.restaurants = bussiness
                                
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
