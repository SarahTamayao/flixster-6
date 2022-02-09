//
//  MovieGridViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/6/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var superheroMovies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Define the layout properties for the Collection View. Want 3 across, with a divider in between each movie
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - (layout.minimumInteritemSpacing * 2)) / 3      // Account for the two vertical dividers
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)

        // Do any additional setup after loading the view.
        
        // Get the superhero movie data for movies that are similar to Wonder Women (id = 297762) from the API endpoints
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=5766b4fa8a6980ba5b2e528f85f35b9f")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                    self.superheroMovies = dataDictionary["results"] as! [[String:Any]]
                    
                    // Reload the collection with the data that has arrived.
                    self.collectionView.reloadData()
             }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Define the number of items in the collectionView based on number of movies pulled during API request
        return superheroMovies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Send the image URL from the superheroMovies dictionary to the imageView
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = superheroMovies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
    
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
        
//        // Remove the highlighted selection
//        collectionView.deselectRow(at: indexPath, animated: true)
//
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
