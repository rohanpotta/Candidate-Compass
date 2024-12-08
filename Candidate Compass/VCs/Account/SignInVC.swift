import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: CustomPasswordTF!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var hideButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var titleLabel: UINavigationItem!
    
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 1.0
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
        titleLabel.titleView?.tintColor = UIColor.white
        errorLabel.isHidden = true
        errorLabel.font = UIFont(name: "Arvo", size: 18)
        welcomeLabel.font = UIFont(name: "Arvo", size: 21)
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arvo", size: 20) ?? UIFont.systemFont(ofSize: 17),
        ]
        let attributedTitleSignIn = NSAttributedString(string: "Sign In", attributes: fontAttributes)
        signInButton.setAttributedTitle(attributedTitleSignIn, for: .normal)
        let attributedTitleForgot = NSAttributedString(string: "Forgot Password?", attributes: fontAttributes)
        forgotPasswordButton.setAttributedTitle(attributedTitleForgot, for: .normal)
    }
    
    @IBAction func hideButtonClicked(_ sender: Any) {
        passwordTF.isSecureTextEntry.toggle()
                
        if passwordTF.isSecureTextEntry {
            hideButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            hideButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (firebaseResult, error) in
            if let error = error {
                let errorCode = (error as NSError).code
                var errorMessage: String

                switch errorCode {
                case AuthErrorCode.wrongPassword.rawValue:
                    errorMessage = "Password is incorrect!"
                case AuthErrorCode.userNotFound.rawValue:
                    errorMessage = "Account doesn't exist!"
                default:
                    errorMessage = "An error occurred. Please try again."
                }

                self.showError(message: errorMessage)
                return
            } else {
                self.performSegue(withIdentifier: "goToTBC", sender: self)
            }
        }
    }
}
