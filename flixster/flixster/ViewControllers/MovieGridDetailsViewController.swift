//
//  MovieGridDetailsViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/8/22.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class MovieGridDetailsViewController: UIViewController, UIGestureRecognizerDelegate{

    // MARK: - IBOutlets
    
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    
    // MARK: - View Life Cycle
    
    var movieVideos = [[String: Any]]()
    var superHeroMovie: MovieDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = superHeroMovie.title!
        let synopsis = superHeroMovie.synopsis!
        
        titleLabel.text = title
        synopsisLabel.text = synopsis
        
        backdropView.af.setImage(withURL: superHeroMovie.backDropURL!)
        posterView.af.setImage(withURL: superHeroMovie.posterURL!)
        
        // Ensures gesture can be registered
        posterView.isUserInteractionEnabled = true
    }
    
    // MARK: - IBActions

    @IBAction func posterTapped(_ sender: UITapGestureRecognizer) {
        // User tapped on the poster, get the trailer URL and send it during segue
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(superHeroMovie.movieID!)/videos?api_key=5766b4fa8a6980ba5b2e528f85f35b9f&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (dataFromNetworking, response, error) in
             // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let dataFromNetworking = dataFromNetworking {
                
                do {
                    let dataDictionary = try JSON(data: dataFromNetworking)
                    
                    // Grab the first set of data from the API array and convert it into VideosForMovie model
                    let trailerDetails = VideosForMovie.init(json: dataDictionary["results"][0])
                
                    do {
                        let movieTrailerURL = try trailerDetails.getYoutubeLink()
                        self.performSegue(withIdentifier: "segueToTrailerController", sender: movieTrailerURL)
                        
                    } catch Error.Failure {
                        // Either was not a trailer, or the site was not YouTube
                        print(error!.localizedDescription)
                    }
                } catch {
                    // Error in fetching the API endpoint data
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
        
    }
    
    // MARK: - Navigation, prepare for segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
        // Pass the selected object ((to the new view controller.
        if segue.identifier == "segueToTrailerController" {
            guard let trailerURL = sender as? URL else {
                return
            }
            let movieTrailerViewController = segue.destination as! MovieTrailerViewController
            movieTrailerViewController.trailerURL = trailerURL
        }
    }
}
