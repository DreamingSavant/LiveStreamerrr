//
//  Video.swift
//  LiveStreamerrr
//
//  Created by Roderick Presswood on 7/24/25.
//

import Foundation

//MARK: - Model
struct Video: Codable {
    let id: Int
    let url: String
    let image: String
    let videoFiles: [VideoFile]
    
    enum CodingKeys: String, CodingKey {
        case id, url, image = "image"
        case videoFiles = "video_files"
    }
}
