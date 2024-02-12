//
//  ImageLoader.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import Foundation

final class ImageLoader {
    static let shared = ImageLoader()
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {
    }
    
    public func downLoadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
