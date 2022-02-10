//
//  MovieGridViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/6/22.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    var superheroMovies = [MovieDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Define the layout properties for the Collection View. Want 3 across, with a divider in between each movie
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - (layout.minimumInteritemSpacing * 2)) / 3      // Account for the two vertical dividers
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)                       // Defines size of each movie grid

        // Get the superhero movie data for movies that are similar to Wonder Women (id = 297762) from the API endpoints
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=5766b4fa8a6980ba5b2e528f85f35b9f")!
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
                         self.superheroMovies.append(MovieDetails.init(json: movieData))
                     }
                     
                     // Reload the collection with the data that has arrived.
                     self.collectionView.reloadData()
                     
                 } catch {
                     // Couldn't read in the JSON data correctly
                     print(error.localizedDescription)
                 }
             }
        }
        task.resume()
    }
    
    // MARK: - Collection view functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Define the number of items in the collectionView based on number of movies pulled during API request
        return superheroMovies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Send the image URL from the superheroMovies dictionary to the imageView, load the image using Alamofire
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = superheroMovies[indexPath.item]

        cell.posterView.af.setImage(withURL: movie.posterURL!)
        
        return cell
    }
    
    // MARK: - Navigation, prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
        // Pass the selected object to the new view controller.
        
        // Find selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let superHeroMovie = superheroMovies[indexPath.item]
        
        
        // Pass movie dictionary to MoviesGridDetailsViewController
        let gridDetailsViewController = segue.destination as! MovieGridDetailsViewController
        
        gridDetailsViewController.superHeroMovie = superHeroMovie
        
    }
}
