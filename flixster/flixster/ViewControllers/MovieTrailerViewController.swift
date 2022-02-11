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

    // MARK: - View Life Cycle - Load webview with given video URL

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let trailerURL = trailerURL!
        let myRequest = URLRequest(url: trailerURL)
        self.webView.load(myRequest)
    }
    
}
