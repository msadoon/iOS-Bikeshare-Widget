import SwiftUI
import MapKit

final class StationsViewModel: ObservableObject {
    @Published var stations = [Station]()
    @Published var stationsUpdatedForUserLocation = false
    
    private let stationsStore = StationsStoreImpl()
    
    func getStations(userLocation: CLLocation?) {
        
        stationsStore.fetch { result in
            switch result {
            case .success(let stations):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    if let userLocation = userLocation {
                        strongSelf.stations = strongSelf.closestLocations(to: userLocation,
                                                                          stations: stations,
                                                                          maxMetersDistance: nil)
                        strongSelf.stationsUpdatedForUserLocation = true
                    } else {
                        strongSelf.stationsUpdatedForUserLocation = false
                        strongSelf.stations = stations
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func closestLocations(to userLocation: CLLocation,
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
