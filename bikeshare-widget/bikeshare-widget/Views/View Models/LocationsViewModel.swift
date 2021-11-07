import CoreLocation
import MapKit

enum LocationDefaults {
    /**
     - 1 degree delta is equal to about 69 miles
     - 0.310686 miles = 500 meters
    **/
    static let span = MKCoordinateSpan(latitudeDelta: (0.310686 / 69),
                                       longitudeDelta: (0.310686 / 69))
    static let coordinate = CLLocationCoordinate2D(latitude: 43.653908,
                                                   longitude: -79.384293)
}

final class LocationsViewModel: NSObject,
                               CLLocationManagerDelegate,
                               ObservableObject {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: LocationDefaults.coordinate,
                                               span: LocationDefaults.span)
    @Published var userLocation: CLLocation?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.activityType = .fitness
            locationManager?.delegate = self
        } else {
            print("Show an alert to inform user they need to turn on location services.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied location permissions for this app. Go to Settings to change it.")
        case .authorized,
             .authorizedAlways,
             .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? LocationDefaults.coordinate,
                                        span: LocationDefaults.span)
            userLocation = locationManager.location
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
