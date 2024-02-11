//
//  Request.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//


/*
 request for  specific dates
 https://api.nasa.gov/planetary/apod?api_key=hfJaNzi992ijkjUfwdhYpkqIq9wJcv9tMpGrUDcr&start_date=2017-07-08&end_date=2017-07-10
 request for today
 https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY
 request count - random dates
 https://api.nasa.gov/planetary/apod?api_key=hfJaNzi992ijkjUfwdhYpkqIq9wJcv9tMpGrUDcr&count=20
 */
import Foundation

final class Request {
    private struct Constants {
        static let baseURL = "https://api.nasa.gov/planetary/apod?api_key="
        static let key = "hfJaNzi992ijkjUfwdhYpkqIq9wJcv9tMpGrUDcr"
    }
    
    let pathComponents: [String]
    
    // base url + key = today pic
    // base url + key + dates = array of pics
    public var urlString: String {
        var string = Constants.baseURL
        string += Constants.key

        if pathComponents.count == 2 {
            string += "&start_date=2017-07-08&end_date=2017-07-10"
//            pathComponents.forEach ({
//                string += $0
//            })
        }
        if pathComponents.count == 1 {
            string += "&count=20"
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(pathComponents: [String] = []) { // endPoint: Endpoint
        self.pathComponents = pathComponents
    }
}

extension Request {
    static let listAPODRequest = Request(pathComponents: ["d"])
}
