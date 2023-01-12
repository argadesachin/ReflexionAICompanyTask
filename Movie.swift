//
//  Movie.swift
//  reflexionCompanyTask
//
//  Created by Mac on 11/01/23.
//

import Foundation
struct apiResponse{
    let movieList: [MovieList]
       enum CodingKeys: String, CodingKey {
           case movieList = "Movie List"
       }
}
struct MovieList{
    let Title: String
    let Year: String
    let Runtime: String
    let Cast: String
}
