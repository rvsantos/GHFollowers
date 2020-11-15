//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 14/11/20.
//

import Foundation

class NetworkManager {
    
    //MARK:- Object
    static let shared   = NetworkManager()
    
    
    //MARK:- Constants
    let baseUrl         = "https://api.github.com"
    
    
    //MARK:- Initialization
    private init() {}
    
    
    //MARK:- Methods
    typealias followerClosure = ([Follower]?, ErrorMessage?) -> Void
    func getFollowers(for username: String, page: Int, completed: @escaping followerClosure) {
        let endpoint = self.baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        task.resume()
    }
    
}
