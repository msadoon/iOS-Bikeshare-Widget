import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private var completionHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
    }
    
    private var isAuthorized: Bool {
        return [CLAuthorizationStatus.authorizedAlways, CLAuthorizationStatus.authorizedWhenInUse].contains(manager.authorizationStatus) && manager.isAuthorizedForWidgetUpdates
    }
    
    func fetchLocation(handler: @escaping (CLLocation) -> Void) {
        completionHandler = handler
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            if strongSelf.isAuthorized {
                strongSelf.manager.requestLocation()
            } else {
                strongSelf.manager.requestWhenInUseAuthorization()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        completionHandler?(lastLocation)
    }
}
