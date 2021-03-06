//
//  RegisterViewController.swift
//  Reci-Pie
//
//  Created by Vi Nguyen on 3/13/22.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hides keyboard when tapping outside the keyboard
        self.hideKeyboardWhenTappedAround()
    }
    

    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
          // other fields can be set just like with PFObject
        user["firstName"] = firstNameField.text
        user["lastName"] = lastNameField.text
        
        user.signUpInBackground{(success, error) in
            if success {
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
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
