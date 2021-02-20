//
//  StationsStore.swift
//  bikeshare-widget
//
//  Created by Tom McNeely on 2021-02-20.
//

import Foundation


protocol StationsStore {
    func refresh()
    
    var stationsResult: Result<[Station], APIError> { get }
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
    
    func refresh() {
        let urlString = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information"
        api.getResource(urlString: urlString) { [weak self] (result: Result<StationInformationResponse, APIError>) in
            switch result {
            case let .success(response):
                self?.stationsResult = .success(response.data.stations)
            case let .failure(error):
                self?.stationsResult = .failure(error)
            }
        }
    }
}
