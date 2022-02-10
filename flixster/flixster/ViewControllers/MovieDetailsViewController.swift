//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/6/22.
//

import UIKit
import AlamofireImage
import SwiftyJSON


class MovieDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    var movie: MovieDetails!
    var dialogMessage: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie.title!
        let synopsis = movie.synopsis!
        
        titleLabel.text = title
        synopsisLabel.text = synopsis

        backdropView.af.setImage(withURL: movie.backDropURL!)
        posterView.af.setImage(withURL: movie.posterURL!)
        
        // Ensures gesture can be registered
        posterView.isUserInteractionEnabled = true
        
        // Create new Alert when no YouTube trailer found
        dialogMessage = UIAlertController(title: "Alert", message: "No YouTube Trailer Found", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in return})
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
    }

    // MARK: - IBActions

    @IBAction func posterTapped(_ sender: UITapGestureRecognizer) {
        // User tapped on the poster, get the trailer URL and send it during segue
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.movieID!)/videos?api_key=5766b4fa8a6980ba5b2e528f85f35b9f&language=en-US")!
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
                    // Then, see if it contains a YouTube Trailer
                    for setOfTrailerDetails in dataDictionary["results"] {
                        let trailerDetails = VideosForMovie.init(json: setOfTrailerDetails.1)
                        
                        if trailerDetails.trailerSite == "YouTube" && trailerDetails.trailerType == "Trailer" {
                            let movieTrailerURL = trailerDetails.movieLink!
                            self.performSegue(withIdentifier: "segueFromMovieDetails", sender: movieTrailerURL)
                            break
                        }
                    }
                    
                    // Present Alert since couldn't find a YouTube video
                    self.present(self.dialogMessage, animated: true, completion: nil)
                    
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
        if segue.identifier == "segueFromMovieDetails" {
            guard let trailerURL = sender as? URL else {
                return
            }
            let movieTrailerViewController = segue.destination as! MovieTrailerViewController
            movieTrailerViewController.trailerURL = trailerURL
        }
    }
    
    
    
}
