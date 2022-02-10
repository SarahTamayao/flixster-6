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

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: MovieDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie.title!
        let synopsis = movie.synopsis!
        
        titleLabel.text = title
        synopsisLabel.text = synopsis

        backdropView.af.setImage(withURL: movie.backDropURL!)
        posterView.af.setImage(withURL: movie.posterURL!)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
