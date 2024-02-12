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
        ImageLoader.shared.downLoadImage(url, completion: completion)
    }
    
    // MARK: Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(imageURL)
    }
    
    static func == (lhs: APODCollectionViewCellViewModel, rhs: APODCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
