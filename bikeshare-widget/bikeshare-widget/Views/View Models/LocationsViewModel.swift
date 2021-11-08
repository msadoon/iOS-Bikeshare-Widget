import CoreLocation
import MapKit
import SwiftUI

public enum LocationDefaults {
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
    private let stationsStore = StationsStoreImpl()
    private var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion()
    @Published var stations = [Station]()
    
    func updateLocationAndStations() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.activityType = .fitness
            locationManager?.delegate = self
        } else {
            print("Show an alert to inform user they need to turn on location services.")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    private func updateRegion(to region: MKCoordinateRegion) {
        self.region = region
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
            refreshCurrentUserLocation()
            getStations() { [weak self] stations, location in
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    strongSelf.stations = strongSelf.updateStations(to: location,
                                                                    stations: stations,
                                                                    maxMetersDistance: nil)
                }
            }
        @unknown default:
            break
        }
    }
    
    private func refreshCurrentUserLocation() {
        guard let locationManager = locationManager,
              let userActualLocation = locationManager.location?.coordinate else {
            return
        }
        
        let newRegion = MKCoordinateRegion(center:  userActualLocation,
                                           span: LocationDefaults.span)
        
        self.region = newRegion
    }
    
    private func getStations(handler: @escaping ([Station], CLLocation) -> Void) {
        stationsStore.fetch { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let fetchedStations):
                let userCurrentLocation = CLLocation(latitude: strongSelf.region.center.latitude,
                                                     longitude: strongSelf.region.center.longitude)
                
                handler(fetchedStations, userCurrentLocation)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateStations(to userLocation: CLLocation,
                                stations: [Station],
                        maxMetersDistance: Double?) -> [Station] {
        var allDistancesToUser = [(Double, Station)]()
        
        for station in stations {
            let comparableLocation = CLLocation(latitude: station.coordinates.latitude,
                                                longitude: station.coordinates.longitude)
            let distanceToUser = comparableLocation.distance(from: userLocation)
            let distanceAndStation = (distanceToUser, station)
            
            if let maxMetersDistance = maxMetersDistance {
                if distanceToUser <= maxMetersDistance {
                    allDistancesToUser.append(distanceAndStation)
                }
            } else {
                allDistancesToUser.append(distanceAndStation)
            }
        }
        
        let closestStationDistancesToUser = allDistancesToUser.sorted(by: { $0.0 < $1.0 })
        let closestStationsToUser = closestStationDistancesToUser.map({ (accurateDistance, station) -> Station in
            let updatedStationWithDistance = Station(id: station.id,
                                                     name: station.name,
                                                     address: station.address,
                                                     bikeCapacity: station.bikeCapacity,
                                                     distance: accurateDistance,
                                                     coordinates: station.coordinates)
            
            return updatedStationWithDistance
        })
        
        return closestStationsToUser
    }
}
