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
    
    public func execute<T: Codable>(_ request: Request,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) { // return T?
        // TODO: define T type -> make different requests
            AF.request(request.urlString).responseDecodable(of: [APODModel].self) { response in
                guard let models = response.value else { return }
                print(models)
            }
    }
}
