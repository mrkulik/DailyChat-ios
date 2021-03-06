//
//  ViewController.swift
//  DailyChat
//
//  Created by Gleb Kulik on 2/23/17.
//  Copyright © 2017 Gleb Kulik. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "DL_Background")
        self.view.insertSubview(backgroundImage, at: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        if AuthProvider.Instance.isLoggedIn() {
            performSegue(withIdentifier: Const.TAB_SEGUE, sender: nil)
        }
    }

    @IBAction func login(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            AuthProvider.Instance.logIn(withEmail: emailTextField.text! , password: passwordTextField.text! , loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: Const.AUTH_ERROR, message: message!)
                } else {
                    print(Const.LOGGED_IN)
                    
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    
                    self.performSegue(withIdentifier: Const.TAB_SEGUE, sender: nil)
                }
                
            })
            
        } else {
            alertTheUser(title: Const.EMAIL_PASSWORD_REQUIRE, message: Const.REQUIRE_MESSAGE)
        }
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: Const.PROBLEM_WITH_CREATE, message: message!)
                } else
                {
                    print(Const.CREATED)
                    
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    
                    self.performSegue(withIdentifier: Const.SET_SEGUE, sender: nil)
                }
            })
            
        } else {
            alertTheUser(title: Const.EMAIL_PASSWORD_REQUIRE, message: Const.REQUIRE_MESSAGE)
        }
        
    }
    
    private func alertTheUser(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: Const.OK, style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }

}

