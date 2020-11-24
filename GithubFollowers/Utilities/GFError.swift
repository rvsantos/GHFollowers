//
//  GFError.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 17/11/20.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created a n invalid request. Please try again."
    case unableToComplete   = "Unable to complete your resquest. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorites  = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites  = "You've already favorited this user. Please try again. "
}
