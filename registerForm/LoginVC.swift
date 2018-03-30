//
//  LoginVC.swift
//  registerForm
//
//  Created by Andrew on 30.03.2018.
//  Copyright © 2018 Andrew. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorners()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func roundCorners() {
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 5
        signInButton.layer.masksToBounds = true
        signInButton.layer.cornerRadius = 5
    }
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func goTomainScreenI() {
        // func go to main screen if login successful
    }

    @IBAction func singInButton(_ sender: Any) {
        let username = loginTextField.text
        let password = passwordTextField.text
        if username == "" || password == "" {
            self.alert(message:"Please enter your data to field", title: "Empty field")
        } else {
            // Defining the user object
            PFUser.logInWithUsername(inBackground: username!, password: password!, block: {(user, error) -> Void in
                if let error = error as NSError? {
                    let errorString = error.userInfo["error"] as? NSString
                    self.alert(message: errorString!, title: "Error")
                }
                else {
                    self.alert(message: "Login was successful", title: "Successful")
                    self.goTomainScreenI()
                }
            })
        }
    }
    

}
