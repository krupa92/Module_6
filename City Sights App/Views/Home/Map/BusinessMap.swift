//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Krupa Patel on 4/8/2022.
//

import SwiftUI
import MapKit

struct BusinessMap : UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    //typealias UIViewType = MKMapView
    
    @EnvironmentObject var model:ContentModel
    @Binding var selectedBusiness:Business?
    
    var locations:[MKPointAnnotation] {
        
        var annotation = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            
            if let lati = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                var a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lati, longitude: long)
                a.title = business.name ?? ""
                
                annotation.append(a)
            }
        }
        return annotation
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    //MARK - coodinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject , MKMapViewDelegate {
        
        var map:BusinessMap
        
        init(map:BusinessMap) {
            
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                
                return nil
            }
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "bussiness")
            
            if annotationView == nil {
                
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "bussiness")
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            for business in map.model.restaurants + map.model.sights {
                
                if business.name == view.annotation?.title {
                    
                    map.selectedBusiness = business
                    return
                }
            }
        }
        
        
    }
}
