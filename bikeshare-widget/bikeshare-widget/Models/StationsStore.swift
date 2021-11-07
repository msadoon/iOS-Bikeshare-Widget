import Foundation

protocol StationsStore {
    func fetch(completion: @escaping ((Result<[Station], APIError>) -> Void))
}

fileprivate struct StationInformationResponse: Codable {
    
    struct StationInformationData: Codable {
        let stations: [Station]
    }
    
    let data: StationInformationData
}

class StationsStoreImpl: StationsStore {
    
    private let api: APIService
    
    private (set) var stationsResult: Result<[Station], APIError>
    
    init(api: APIService = APIServiceImpl()) {
        self.api = api
        self.stationsResult = .success([])
    }
    
    func fetch(completion: @escaping ((Result<[Station], APIError>) -> Void)) {
        guard let encodedData = UserDefaults(suiteName: "group.mubarak.bikeshare-widget")?.object(forKey: "stations") as? Data,
        let decodedStations = try? JSONDecoder().decode([Station].self, from: encodedData) else {

            let urlString = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information"
            api.getResource(urlString: urlString) { (result: Result<StationInformationResponse, APIError>) in
                // TODO: Handle error?
                
                let stationsResponse = result.map { $0.data.stations }
                
                switch stationsResponse {
                case .success(let stations):
                    let encodeStations = try? JSONEncoder().encode(stations)
                    
                    UserDefaults(suiteName: "group.mubarak.bikeshare-widget")?.set(encodeStations, forKey: "stations")
                case .failure:
                    break
                }
                
                completion(stationsResponse)
            }
            
            return
        }
        
        completion(.success(decodedStations))
    }
}
