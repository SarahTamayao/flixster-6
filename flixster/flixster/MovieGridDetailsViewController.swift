//
//  MovieGridDetailsViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/8/22.
//

import UIKit
import AlamofireImage

class MovieGridDetailsViewController: UIViewController {

    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    
    
    var superHeroMovie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = superHeroMovie["title"] as! String
        let synopsis = superHeroMovie["overview"] as! String
        
        titleLabel.text = title
        synopsisLabel.text = synopsis
        
        let posterbaseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = superHeroMovie["poster_path"] as! String
        let posterUrl = URL(string: posterbaseUrl + posterPath)
        
        let backdropbaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = superHeroMovie["backdrop_path"] as! String
        let backdropUrl = URL(string: backdropbaseUrl + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
        posterView.af.setImage(withURL: posterUrl!)

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func didTapPoster(_ sender: UITapGestureRecognizer) {
//        performSegue(withIdentifier: "MovieTrailerViewController", sender: sender)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
