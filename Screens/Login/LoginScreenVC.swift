
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
        let networkService = NetworkService()
        loginTF.isEnabled = false
        passwordTF.isEnabled = false
        
        
        networkService.login(login: login, password: password){ [weak self] result in
            
            if result.success {
                
                guard let mainVC = self?.storyboard?.instantiateViewController(identifier: "main") as? TapBarVC else {
                    return
                }
                mainVC.modalPresentationStyle = .fullScreen
                mainVC.modalTransitionStyle = .flipHorizontal
                self?.present(mainVC, animated: true)
                
            } else {
                
                print(result.message)
                
            }
            self?.loginTF.isEnabled = true
            self?.passwordTF.isEnabled = true
            
        }
        
    }
    
}

