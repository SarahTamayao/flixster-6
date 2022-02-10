//
//  MoviesViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 1/30/22.
//

import UIKit
import AlamofireImage
import SwiftyJSON  // https://github.com/SwiftyJSON/SwiftyJSON#why-is-the-typical-json-handling-in-swift-not-good


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [MovieDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Any additional setup after loading the view
        
        // Get the superhero movie data for movies that are similar to Wonder Women (id = 297762) from the API endpoints
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=5766b4fa8a6980ba5b2e528f85f35b9f")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (dataFromNetworking, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let dataFromNetworking = dataFromNetworking {
                 
                 do {
                     let dataDictionary = try JSON(data: dataFromNetworking)
                     for singleMovie in dataDictionary["results"] {
                         let movieData = singleMovie.1
                         self.movies.append(MovieDetails.init(json: movieData))
                     }
                     
                     self.tableView.reloadData()
                     
                 } catch {
                     print(error.localizedDescription)
                 }
             }
        }
        task.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Determines how many rows in the table
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Defines what is displayed in each cell or row, where the index of the given cell is given through indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie.title!
        let synopsis = movie.synopsis!
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        cell.posterView.af.setImage(withURL: movie.posterURL!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
        // Pass the selected object to the new view controller.
        
        // Find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // Pass movie dictionary to MovieDetailsViewController
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        // Remove the highlighted selection
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
