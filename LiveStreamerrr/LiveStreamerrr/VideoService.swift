//
//  VideoService.swift
//  LiveStreamerrr
//
//  Created by Roderick Presswood on 7/24/25.
//

import Foundation

// api key u9FLyIWLVXIHAzkaZOLKe5AVM1BUMWsv1Tbam1P2EqJUeFhVDzjhgvoG

class VideoService {
    static let shared = VideoService()
    private let apiKey = "u9FLyIWLVXIHAzkaZOLKe5AVM1BUMWsv1Tbam1P2EqJUeFhVDzjhgvoG"
    private let urlString = "https://api.pexels.com/videos/search?query=nature"//&per_page=10"
    
    func fetchVideos(completion: @escaping ([Video]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown")")
                return
            }
            do {
                let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.videos)
                }
            } catch {
                print("Decoding error: \(error)")
            }
            
        }.resume()
    }
}
