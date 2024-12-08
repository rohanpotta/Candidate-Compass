import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: CustomPasswordTF!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var hideButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var passwordInfoLabel: UILabel!
    
    func showError() {
        errorLabel.text = "Account already exists!"
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 1
        errorLabel.isHidden = false

        UIView.animate(withDuration: 3.0, animations: {
            self.errorLabel.alpha = 0.0
        }) { _ in
            self.errorLabel.isHidden = true
            self.errorLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInfoLabel.font = UIFont(name: "Arvo", size: 16)
        passwordInfoLabel.textColor = UIColor.systemBackground
        errorLabel.isHidden = true
        errorLabel.font = UIFont(name: "Arvo", size: 18)
        welcomeLabel.font = UIFont(name: "Arvo", size: 21)
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arvo", size: 20) ?? UIFont.systemFont(ofSize: 17),
        ]
        let attributedTitleSignUp = NSAttributedString(string: "Sign Up", attributes: fontAttributes)
        signUpButton.setAttributedTitle(attributedTitleSignUp, for: .normal)
    }
    
    @IBAction func hideButtonClicked(_ sender: Any) {
        passwordTF.isSecureTextEntry.toggle()
                
        if passwordTF.isSecureTextEntry {
            hideButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            hideButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) 
    {
        guard let email = emailTF.text, let password = passwordTF.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if error != nil {
                self.showError()
            }
            else {
                self.performSegue(withIdentifier: "goToTBC", sender: self)
            }
        }
    }
}
