//
//  MapView.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/17/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct MapView: UIViewRepresentable {
    
    @Binding var annotations: [MKPointAnnotation]
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
//        let annotation = MKPointAnnotation()
//        annotation.title = "Home"
//        annotation.subtitle = "Our house"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.349968, longitude: -83.051004)
//        mapView.addAnnotation(annotation)
        
        
        
        
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func generateAnnotations() {
        
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.centerCoordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view
    }
}

class ApplicationMapData: ObservableObject {
    @Published var locations = [MKPointAnnotation]()
}
