//
//  StationsStore.swift
//  bikeshare-widget
//
//  Created by Tom McNeely on 2021-02-20.
//

import Foundation

protocol StationsStore {
    func fetch(completion: @escaping ((Result<[Station], APIError>) -> Void))
}

fileprivate struct StationInformationResponse: Decodable {
    
    struct StationInformationData: Decodable {
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
        let urlString = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information"
        api.getResource(urlString: urlString) { (result: Result<StationInformationResponse, APIError>) in
            completion(result.map { $0.data.stations })
        }
    }
}
