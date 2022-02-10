//
//  Models.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/9/22.
//

import Foundation
import SwiftyJSON


struct MovieDetails {
    // Model for an endpoint from https://api.themoviedb.org/3/movie/now_playing?
    
    var title: String?
    var posterPath: String?
    var synopsis: String?
    var backDropPath: String?
    var movieID: Int?
    var backDropURL: URL?
    var posterURL: URL?
    
    init(json : JSON){
        title = json["title"].stringValue
        posterPath = json["poster_path"].stringValue
        synopsis = json["overview"].stringValue
        backDropPath = json["backdrop_path"].stringValue
        movieID = json["id"].intValue
        
        let posterBaseURL = "https://image.tmdb.org/t/p/w185"
        let backDropBaseUrl = "https://image.tmdb.org/t/p/w780"
        
        backDropURL = URL(string: backDropBaseUrl + backDropPath!)
        posterURL = URL(string: posterBaseURL + posterPath!)
    }
}

struct VideosForMovie {
    // Model for an endpoint from https://api.themoviedb.org/3/movie/297762/similar?
    var trailerKey: String?
    var trailerSite: String?
    var trailerType: String?
    var movieLink: String!
    
    init(json: JSON){
        trailerKey = json["key"].stringValue
        trailerSite = json["site"].stringValue
        trailerType = json["type"].stringValue
        movieLink = "https://www.youtube.com/watch?v=" + self.trailerKey!
    }
    
    func getYoutubeLink() throws -> URL{
        guard self.trailerSite == "YouTube" else {
            throw Error.Failure
        }
        
        guard self.trailerType == "Trailer" else {
            throw Error.Failure
        }
        
        return URL(string: self.movieLink)!
    }
}

enum Error: String, LocalizedError {
    case Failure = "Unable to generate YouTube link."
    
    var errorDescription: String? { self.rawValue }
}
