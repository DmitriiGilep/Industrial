//
//  MapViewController.swift
//  Industrial
//
//  Created by DmitriiG on 27.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {

    let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .hybrid
        map.showsCompass = true
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
        
    }()
    
    let manager = CLLocationManager()
    
    lazy var locationUpdateButton = CustomButton(title: ("X", nil), titleColor: (.systemBlue, nil), titleLabelColor: .white, titleFont: nil, cornerRadius: 15, backgroundColor: .white, backgroundImage: (nil, nil), clipsToBounds: true, action: {[weak self] in
        guard let self = self else {return}

        if let coordinate = self.manager.location?.coordinate {
            self.mapView.setCenter(coordinate, animated: true)
        }
       
    })
    
    
    lazy var buildRouteButton = CustomButton(title: ("", nil), titleColor: (nil, nil), titleLabelColor: .white, titleFont: nil, cornerRadius: 5, backgroundColor: nil, backgroundImage: (UIImage(systemName: "arrow.upright.circle"), nil), clipsToBounds: true, action: {[weak self] in
        guard let self = self else {return}

        self.buildRoute()
       
    })
    
    lazy var removeAllPins = CustomButton(title: ("", nil), titleColor: (nil, nil), titleLabelColor: .white, titleFont: nil, cornerRadius: 5, backgroundColor: nil, backgroundImage: (UIImage(systemName: "pin.slash.fill"), nil), clipsToBounds: true, action: { [weak self] in
        
        guard let self = self else {return}
        self.mapView.removeAnnotations(self.mapView.annotations)

    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        mapView.delegate = self
        manager.delegate = self
        manager.requestLocation()
   //     manager.startUpdatingLocation()
        addPin(title: "Moscow", coordinate: CLLocationCoordinate2D(latitude: 55, longitude: 37))
        addRoute(from: CLLocationCoordinate2D(latitude: 54, longitude: 37), to: CLLocationCoordinate2D(latitude: 55, longitude: 37))
    }
    
    private func requestAuthorisation() {
        let currentStatus = manager.authorizationStatus
        
        switch currentStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .notDetermined, .denied, .restricted:
            manager.requestWhenInUseAuthorization()
   //         manager.startUpdatingLocation()
            manager.requestLocation()

        @unknown default:
            print("unknown status")
        }
        
    }
    
    private func setUpMap() {
        view.addSubview(mapView)
        view.addSubview(locationUpdateButton)
        view.addSubview(buildRouteButton)
        view.addSubview(removeAllPins)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            locationUpdateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationUpdateButton.heightAnchor.constraint(equalToConstant: 30),
            locationUpdateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationUpdateButton.widthAnchor.constraint(equalToConstant: 30),
            
            buildRouteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            buildRouteButton.heightAnchor.constraint(equalToConstant: 30),
            buildRouteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buildRouteButton.widthAnchor.constraint(equalToConstant: 30),
            
            removeAllPins.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            removeAllPins.heightAnchor.constraint(equalToConstant: 30),
            removeAllPins.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            removeAllPins.widthAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.desiredAccuracy = 100
        guard let location = locations.first else {return}
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
  //      mapView.setRegion(region, animated: true)
        mapView.setCenter(location.coordinate, animated: true)
        
    }
    
    func buildRoute() {
        if let currentLocationCoordinate = manager.location?.coordinate {
            lazy var alert = CustomAlert.shared.createAlertWithCompletionTwoField(controller: self, title: "Route", message: "Insert coordinate", placeholder1: "Latitude", placeholder2: "Longitude", titleAction: "Build the route") {
                
                let latitudeField = alert.textFields![0]
                let longitudeField = alert.textFields![1]
             
                guard let latitude = Double(latitudeField.text!) else {return}
                guard let longitude = Double(longitudeField.text!) else {return}

                self.addRoute(from: currentLocationCoordinate, to: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
            
            self.present(alert, animated: true)
        } else {
            let alert = CustomAlert.shared.createAlertNoCompletion(title: "Error", message: "Location can't be detected", titleAction: "Ok")
            self.present(alert, animated: true)
        }
    }
    
    func addRoute(from startCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D){
        let request = MKDirections.Request()
        let source = MKPlacemark(coordinate: startCoordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        request.source = MKMapItem(placemark: source)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .any
        let directions = MKDirections(request: request)

        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            guard let response = response else { if let error = error {
                let alert = CustomAlert.shared.createAlertNoCompletion(title: "Error", message: "\(error.localizedDescription)", titleAction: "Ok")
                self.present(alert, animated: true)
                print(error.localizedDescription)
                }
                return
            }
            
            guard let route = response.routes.first else { return }
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func addPin(title: String, coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = title
        mapView.addAnnotation(pin)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestAuthorisation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3
        renderer.strokeColor = .systemRed
        return renderer
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
        
    }
    
}
