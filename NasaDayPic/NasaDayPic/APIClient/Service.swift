//
//  Service.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//

import Foundation

final class Service {
    static let shared = Service()
    
    private init() {}
    
    public func execute(_ request: Request, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}
