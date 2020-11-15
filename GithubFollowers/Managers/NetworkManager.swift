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
    typealias followerClosure = (Result<[Follower], GFError>) -> Void
    func getFollowers(for username: String, page: Int, completed: @escaping followerClosure) {
        let endpoint = self.baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
