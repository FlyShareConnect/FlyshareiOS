//
//  LiveFeedViewController.swift
//  Flyshare
//
//  Created by administrator on 2/8/19.
//  Copyright © 2019 Kriann Atilano. All rights reserved.
//

import UIKit
import WebKit

class LiveFeedViewController: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var LiveWKWebView: WKWebView!
    @IBOutlet weak var GoogleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: "Jrt-g5kwDds")
    }

    @IBAction func GoogleTapped(_ sender: Any)
    {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoogleMapIntegration")
        present(controller, animated: true, completion: nil)
    }
    
    func getVideo(videoCode:String)
    {
        let url = URL(string: "http://www.youtube.com/embed/\(videoCode)")
        LiveWKWebView.load(URLRequest(url: url!))
    }
    
}
