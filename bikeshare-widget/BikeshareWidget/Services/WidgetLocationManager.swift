import Foundation
import CoreLocation

class WidgetLocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = WidgetLocationManager()
    private let manager = CLLocationManager()
    private var completionHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    private var isAuthorized: Bool {
        return manager.isAuthorizedForWidgetUpdates
    }
    
    func fetchLocation(handler: @escaping (CLLocation) -> Void) {
        completionHandler = handler
        
        if isAuthorized {
            manager.requestLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.completionHandler?(lastLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Probably better ways to handle this...
        print(error)
    }
}
