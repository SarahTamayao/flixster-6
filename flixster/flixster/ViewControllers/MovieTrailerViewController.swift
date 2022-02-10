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
    var trailerURL: URL!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //let movieID = movieID!
        let trailerURL = trailerURL!
        let myRequest = URLRequest(url: trailerURL)
        self.webView.load(myRequest)
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
