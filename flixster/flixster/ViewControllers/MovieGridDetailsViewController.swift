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
    
    var superHeroMovie: MovieDetails!
    var noTrailerErrorMessage: UIAlertController!
    var networkErrorMessage: UIAlertController!
    var apiError: UIAlertController!
    
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
        
        // Create new Alert when no YouTube trailer found
        noTrailerErrorMessage = UIAlertController(title: "Alert", message: "No YouTube Trailer Found", preferredStyle: .alert)
        networkErrorMessage = UIAlertController(title: "Alert", message: "No Response from api.themoviedb.org", preferredStyle: .alert)
        apiError = UIAlertController(title: "Alert", message: "Error reading movie details", preferredStyle: .alert)
        
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in return})
        
        //Add OK button to a dialog message
        noTrailerErrorMessage.addAction(ok)
        
    }
    
    // MARK: - IBActions

    @IBAction func posterTapped(_ sender: UITapGestureRecognizer) {
        // User tapped on the poster, get the trailer URL and send it during segue
        
        // Following function is a UIViewController extension
        grabYouTubeTrailerURLandSegue("segueToTrailerController", superHeroMovie.movieID!, self.noTrailerErrorMessage, self.apiError, self.networkErrorMessage)
                
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
