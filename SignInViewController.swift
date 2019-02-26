//
//  SignInViewController.swift
//  Flyshare
//
//  Created by administrator on 2/7/19.
//  Copyright © 2019 Kriann Atilano. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIApplicationDelegate {
    

    @IBOutlet var UserNameTextField: UITextField!
    @IBOutlet weak var UserPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Hide keyboard when user taps outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        
        // Read values from text fields
        let userName = UserNameTextField.text
        let userPassword = UserPasswordTextField.text
        
        // Check if required fields are empty
        if (userName?.isEmpty)! || (userPassword?.isEmpty)!
        {
            // Display alert message here
            print("Username \(String(describing : userName)) or password \(String(describing : userPassword)) is empty")
            displayMessage(userMessage: "One of the required fields is missing.")
            return
        }
        
        // Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        
        // Position activity indicator in the middle
        myActivityIndicator.center = view.center
        
        // Don't hide acitivty indicator
        myActivityIndicator.hidesWhenStopped = false
        
        // Start activity indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController")
        
        if ((UserNameTextField.text?.elementsEqual("Drones"))! == true) && ((UserPasswordTextField.text?.elementsEqual("Drones"))! == true)
        {
            displayMessage(userMessage: "Sign in Successful")
            present(controller, animated: true, completion: nil)
        }
        else
        {
            displayMessage(userMessage: "Sign in Failed")
            return
        }
        
    }
    /*
     // Send HTTP request to perfrom Sign in
     let myUrl = URL(string: "http://localhost:8080/api/authentication")
     var request = URLRequest(url:myUrl!)
     
     request.httpMethod = "POST" // Query string
     request.addValue("application/json", forHTTPHeaderField: "content-type")
     request.addValue("application/json", forHTTPHeaderField: "accept")
     
     let _postString = ["userName": userName!, "userPassword": userPassword!] as [String: String]
     */
    
    func displayMessage(userMessage:String) -> Void
    {
        DispatchQueue.main.async
            {
                let alertController  = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("OK button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
        }
    }    }
    

