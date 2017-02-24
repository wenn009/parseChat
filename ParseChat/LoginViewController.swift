//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Wenn Huang on 2/23/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    private func showAlert(message: String){
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let missingInforAlert = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alertController.addAction(missingInforAlert)
        present(alertController, animated:true, completion:nil)
        
    }
    
    private func getUserInfor() -> (name: String, email: String, password: String)? {
        var name, email, password : String
        
        if let userEmail = emailTextField.text{
            name = userEmail
            email = userEmail
        }else{
            showAlert(message: "Please Enter Your Email!")
            return nil
        }
        if let userPassword = passwordTextField.text {
            password = userPassword
        }else{
            showAlert(message: "Please Enter Your Password!")
            return nil
        }
        return (name, email, password)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func loggingIn(_ sender: UIButton) {
        if let userInfor = getUserInfor(){
            let user = PFUser()
            user.username = userInfor.name
            user.password = userInfor.password
            user.email = userInfor.email
            
            PFUser.logInWithUsername(inBackground: user.email!, password: user.password!, block: {(user,error) in
                if user != nil{
                    self.performSegue(withIdentifier: "toUserFeed", sender: nil) }else {
                self.showAlert(message: "Error, Please try again")
                    }
                })
        }
    
        
    }
    
    @IBAction func signingUp(_ sender: UIButton) {
        if let userInfor = getUserInfor(){
            let user = PFUser()
            user.username = userInfor.name
            user.password = userInfor.password
            user.email = userInfor.email
        // other fields can be set just like with PFObject
        
            user.signUpInBackground(){ (success, error) in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toUserFeed", sender: nil)
                }
                
            }
        
            
        }
    
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
