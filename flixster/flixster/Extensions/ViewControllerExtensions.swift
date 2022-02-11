//
//  ViewControllerExtensions.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/10/22.
//

import UIKit
import SwiftyJSON

// MARK: - UIViewController Extensions

extension UIViewController {
    
    // MARK: Method uses a given movieID to grab the YouTube trailer from the API endpoint.
    // If no YouTube Trailer is found, pops up an error message.
    // If trailer is found, segues based on the given segueIdentifier.
    func grabYouTubeTrailerURLandSegue(_ segueIdentifier: String, _ movieID: Int, _ noTrailerError: UIAlertController, _ errorWithAPIData: UIAlertController, _ errorWithNetwork: UIAlertController) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=5766b4fa8a6980ba5b2e528f85f35b9f&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (dataFromNetworking, response, error) in
             // This will run when the network request returns
            if let error = error {
                self.present(errorWithNetwork, animated: true, completion: nil)
                print(error.localizedDescription)
            } else if let dataFromNetworking = dataFromNetworking {
                
                do {
                    let dataDictionary = try JSON(data: dataFromNetworking)
                    
                    // Grab the first set of data from the API array and convert it into VideosForMovie model
                    // Then, see if it contains a YouTube Trailer
                    for setOfTrailerDetails in dataDictionary["results"] {
                        let trailerDetails = VideosForMovie.init(json: setOfTrailerDetails.1)
                        
                        if trailerDetails.trailerSite == "YouTube" && trailerDetails.trailerType == "Trailer" {
                            let movieTrailerURL = trailerDetails.movieLink!
                            self.performSegue(withIdentifier: segueIdentifier, sender: movieTrailerURL)
                            break
                        }
                    }
                    
                    // Present Alert since couldn't find a YouTube video
                    self.present(noTrailerError, animated: true, completion: nil)
                    
                } catch {
                    // Error in fetching the API endpoint data
                    self.present(errorWithAPIData, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
}
