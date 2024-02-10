//
//  APODModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//

import Foundation

struct APODModel: Codable {
//    let copyright: String? //":"Tommy Lease",
    let date: String //Date //":"2024-02-09"
    let explanation: String
//    let hdurl: String //URL // https://apod.nasa.gov/apod/image/2402/Rosette2024newt533mmcopy.jpg",
//    let media_type: String// ":"image",
//    let service_version: String //":"v1",
    let title: String //":"When Roses Aren't Red",
    let url: String //URL //":"https://apod.nasa.gov/apod/image/2402/Rosette2024newt533mmcopy1024.png"
}
