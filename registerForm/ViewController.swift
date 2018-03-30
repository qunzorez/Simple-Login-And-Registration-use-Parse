//
//  ViewController.swift
//  registerForm
//
//  Created by Andrew on 30.03.2018.
//  Copyright © 2018 Andrew. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func checkField() {
        if loginTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" {
            self.alert(message: "Please enter your data to field", title: "Empty field")
        } else {
            registrationUser()
        }
    }
    
    private func alertWithLogin() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Registering", message: "You are successfully register, please sign in", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (username) in
            username.text = ""
            username.placeholder = "Login:"
        }
        alert.addTextField(configurationHandler: { (passwordField) in
            passwordField.text = ""
            passwordField.placeholder = "Password:"
            passwordField.isSecureTextEntry = true
        })
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let userNameField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let passwordFields = alert?.textFields![1]
            
            let username = userNameField?.text
            let password = passwordFields?.text
            if username == "" || password == "" {
                self.alert(message: "Please enter your data to field", title: "Empty field")
            } else {
                // Defining the user object
                PFUser.logInWithUsername(inBackground: username!, password: password!, block: {(user, error) -> Void in
                    if let error = error as NSError? {
                        let errorString = error.userInfo["error"] as? NSString
                        self.alert(message: errorString!, title: "Error")
                    }
                    else {
                        //go to main screen
                    }
                })
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registrationUser() {
        let username = self.loginTextField.text
        let password = self.passwordTextField.text
        // Defining the user object
        let user = PFUser()
        user.username = username
        user.password = password
        // Just for simplicity
        // Signing up using the Parse API
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
            } else {
                self.alertWithLogin()
            }
        }
        
    }

    @IBAction func registerButton(_ sender: Any) {
        if passwordTextField.text != confirmPasswordTextField.text {
            self.alert(message: "You entered an incorrect password, try the operation again", title: "Registering")
        } else {
            checkField()
        }
    }
    
}

