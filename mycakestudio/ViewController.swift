//
//  ViewController.swift
//  mycakestudio
//
//  Created by Dan Qian on 2019/7/31.
//  Copyright © 2019 dyq. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMapView()
        initImageScrollView()
        
    }
    func initImageScrollView(){
        // set properties
        imageScrollView.isPagingEnabled = true
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.showsHorizontalScrollIndicator = false
        // add images
        var images = [#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img3")] 
        // set images
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(i + 1)
            imageScrollView.addSubview(imageView)
        }
    }
    func initMapView(){
        mapView.delegate = self
        mapView.isZoomEnabled = true
        centerMapOnLocation(location: CLLocation(latitude: 37.546206, longitude: -121.986810));
        
        let location = CustomLocation(title:"My Cake Studio",
                                      locationName:"Fremont Hub",
                                      discipline:"Food",
                                      coordinate: CLLocationCoordinate2D(latitude: 37.545704, longitude: -121.985523 ))
        mapView.addAnnotation(location)
    }
    
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomLocation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    // open map app
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! CustomLocation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
