//
//  MovieGridDetailsViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/8/22.
//

import UIKit
import AlamofireImage

class MovieGridDetailsViewController: UIViewController, UIGestureRecognizerDelegate{

    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    
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
        
        posterView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
        // Pass the selected object to the new view controller.
        let movieID = superHeroMovie.movieID!
        
        let movieTrailerViewController = segue.destination as! MovieTrailerViewController
        movieTrailerViewController.movieID = String(movieID)
        
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

