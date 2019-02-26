//
//  MapViewController.swift
//  Flyshare
//
//  Created by administrator on 2/10/19.
//  Copyright © 2019 Kriann Atilano. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIApplicationDelegate {


    @IBOutlet weak var TestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TestButtonTapped(_ sender: Any)
    {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LiveFeedViewController")
        present(controller, animated: true, completion: nil)
    }
    

}
