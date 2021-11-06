import Foundation

enum APIError: Error {
    case invalidURL(urlString: String)
    case otherError(error: Error)
    case parseError
}

protocol APIService {
    func getResource<T: Decodable>(urlString: String, completion: @escaping ((Result<T, APIError>) -> Void))
}

class APIServiceImpl: APIService {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getResource<T: Decodable>(urlString: String, completion: @escaping ((Result<T, APIError>) -> Void)) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString: urlString)))
            return
        }
        session.dataTask(with: url) { [completion] (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error: error!)))
                return
            }
            guard let nonEmptyData = data else {
                completion(.failure(.parseError))
                return
            }
            let decoder = JSONDecoder()
            guard let object = try? decoder.decode(T.self, from: nonEmptyData) else {
                completion(.failure(.parseError))
                return
            }
            completion(.success(object))
        }.resume()
    }
}
