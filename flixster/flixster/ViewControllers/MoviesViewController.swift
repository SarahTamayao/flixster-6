//
//  MoviesViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 1/30/22.
//
// TODO: Add search function.

import UIKit
import AlamofireImage
import SwiftyJSON  // https://github.com/SwiftyJSON/SwiftyJSON#why-is-the-typical-json-handling-in-swift-not-good


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    
    var movies = [MovieDetails]()
    var networkErrorMessage: UIAlertController!
    var apiError: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create new Alerts with network error and API data error
        networkErrorMessage = UIAlertController(title: "Alert", message: "No Response from api.themoviedb.org", preferredStyle: .alert)
        apiError = UIAlertController(title: "Alert", message: "Error reading movie details", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in return})
        
        //Add OK button to a dialog message
        networkErrorMessage.addAction(ok)
        apiError.addAction(ok)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get the movies that are now playing
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=5766b4fa8a6980ba5b2e528f85f35b9f")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (dataFromNetworking, response, error) in
             // This will run when the network request returns
             if let error = error {
                 self.present(self.networkErrorMessage, animated: true, completion: nil)
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
                     // Couldn't read in the JSON data correctly
                     self.present(self.apiError, animated: true, completion: nil)
                 }
             }
        }
        task.resume()

    }
    
    // MARK: - Table Functions
    
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
        
        cell.movieTitleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        cell.posterView.af.setImage(withURL: movie.posterURL!)
        
        return cell
    }
    
    // MARK: - Navigation, prepare for segue
    
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
