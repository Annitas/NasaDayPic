//
//  Service.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//

import Foundation
import Alamofire

final class Service {
    static let shared = Service()
    
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(_ request: Request,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) { // return T?
        // TODO: define T type -> make different requests
//            AF.request(request.urlString).responseDecodable(of: [APODModel].self) { response in
//                guard let models = response.value else { return }
//                print(models)
//            }
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }

        do {
            let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from adodRequest: Request) -> URLRequest? {
        guard let url = adodRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = adodRequest.httpMethod
        return request
    }
}
