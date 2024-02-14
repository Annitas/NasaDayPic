//
//  APODPhotoCollectionViewCellViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 12.02.2024.
//

import Foundation

final class APODPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) { 
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downLoadImage(imageUrl, completion: completion)
    }
    
}
