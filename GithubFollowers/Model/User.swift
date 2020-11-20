//
//  User.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 14/11/20.
//

import Foundation

struct User: Codable {
    let login:          String
    let avatarUrl:      String
    let htmlUrl:        String
    var name:           String?
    var location:       String?
    var bio:            String?
    let publicRepos:    Int
    let publicGists:    Int
    let following:      Int
    let followers:      Int
    let createdAt:      String
}
