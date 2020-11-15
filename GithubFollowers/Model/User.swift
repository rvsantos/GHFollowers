//
//  User.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 14/11/20.
//

import Foundation

struct User: Codable {
    var login:          String
    var avatarUrl:      String
    var htmlUrl:        String
    var name:           String?
    var location:       String?
    var bio:            String?
    var publicRepos:    Int
    var publicGists:    Int
    var following:      Int
    var followers:      Int
    var createdAt:      String
}
