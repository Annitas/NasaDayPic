//
//  APODCollectionViewCellViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import Foundation
import Alamofire

// TODO: Use Kingfisher

final class APODCollectionViewCellViewModel: Hashable, Equatable {
    public let title: String
    private let imageURL: URL?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(imageURL)
    }
    
    static func == (lhs: APODCollectionViewCellViewModel, rhs: APODCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
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
