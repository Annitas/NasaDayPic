//
//  APODCollectionViewCellViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import Foundation
import Alamofire

final class APODCollectionViewCellViewModel {
    public let title: String
    private let imageURL: URL?
    
    init(title: String, imageURL: URL?){
        self.title = title
        self.imageURL = imageURL
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
//        AF.request(imageURLString).responseDecodable(of: Data.self) { response in
//            guard let data = response.value else { return }
//            
//            print(data)
//        }
        guard let url = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
