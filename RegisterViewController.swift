//
//  RegisterViewController.swift
//  Flyshare
//
//  Created by administrator on 2/6/19.
//  Copyright © 2019 Kriann Atilano. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var NewFNameTextF: UITextField!
    @IBOutlet weak var NewEmailTextF: UITextField!
    @IBOutlet weak var NewPasswordTextF: UITextField!
    @IBOutlet weak var ConfirmPasswordTextF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Hide keyboard when user taps outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        // Validate if required fields are empty
        if  (NewFNameTextF.text?.isEmpty)! ||
            (NewEmailTextF.text?.isEmpty)! ||
            (NewPasswordTextF.text?.isEmpty)! ||
            (ConfirmPasswordTextF.text?.isEmpty)!
        {
            // Display alert message and return
            displayMessage(userMessage: "All fields are required.")
            return
        }
        
        // Validate password
        if  ((NewPasswordTextF.text?.elementsEqual(ConfirmPasswordTextF.text!))! != true)
        {
            // Display alert message and return
            displayMessage(userMessage: "Passwords don't match.")
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
        
        // Send HTTP request to register user
        let myURL = URL(string: "http://localhost:8080/api/users")
        var request = URLRequest(url:myURL!)
        request.httpMethod = "POST" // Query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let _postString = ["firstName": NewFNameTextF.text!,
                          "emailAddress": NewEmailTextF.text!,
                          "passWord": NewPasswordTextF.text!,
                          "confirmPassword": ConfirmPasswordTextF.text!] as [String: String]
        
        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: _postString, options: .prettyPrinted)
        }
        catch
            let error
            {
                print(error.localizedDescription)
                displayMessage(userMessage: "Something went wrong. Try again.")
                return
            }
        
        let task = URLSession.shared.dataTask(with: request)
            {
                (data: Data?, response: URLResponse?, error: Error?) in
            
                self.remoteActivityIndicator(activityIndicator: myActivityIndicator)
            
                if error != nil
                {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print("error=\(String(describing: error))")
                }
            
        // Convert response sent from a server side code to a NSDictionary object:
        
        do
        {
            let json = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers) as? NSDictionary
            
            if let parseJSON = json
                {
                let userId = parseJSON["userId"] as? String
                print ("User Id: \(String(describing: userId!))")
                
                    if (userId?.isEmpty)!
                    {
                    // Display alert dialog with an error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                    return
                    }
                    else
                    {
                    self.displayMessage(userMessage: "Successfully registered a new account. Please proceed to sign in.")
                    }
                }
                else
                {
                // Display alert dialog with an error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                }
        }
        catch
        {
            self.remoteActivityIndicator(activityIndicator: myActivityIndicator)
            self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
        }
        }
        task.resume()
    }
    func remoteActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
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
    }
    
}
    



