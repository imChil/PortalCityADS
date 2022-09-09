
import UIKit

class LoginScreenVC: UIViewController {
    
//    @IBOutlet var login = UITextField!
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.layer.cornerRadius = 15
        loginTF.font = UIFont(name: "Optima", size: 17)
        
    }

    @IBAction func toMain(_ sender: Any) {
        
        let login = loginTF.text ?? ""
        let password = passwordTF.text ?? ""
        
        if loginCityAds(login: login, password: password) {
            
            guard let mainVC = storyboard?.instantiateViewController(identifier: "main") as? TapBarVC else {
                return
            }
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .flipHorizontal
            present(mainVC, animated: true)
        }
        
    }
    
}

