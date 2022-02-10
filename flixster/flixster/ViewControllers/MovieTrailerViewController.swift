//
//  MovieTrailerViewController.swift
//  flixster
//
//  Created by Giovanni Propersi on 2/8/22.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var trailerURL: String!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    var movieID: String!
    var movieVideos = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieID = movieID!
        
        // Get the superhero trailer data for the specified movieID
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=5766b4fa8a6980ba5b2e528f85f35b9f&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    self.movieVideos = dataDictionary["results"] as! [[String:Any]]
                 
                    let movieTrailerID = self.movieVideos[0]["key"]
                    let movieTrailerURL = URL(string: "https://www.youtube.com/watch?v=\(movieTrailerID!)")
                    let myRequest = URLRequest(url: movieTrailerURL!)
                    self.webView.load(myRequest)

                    //elf.tableView.reloadData()
             }
        }
        task.resume()

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
