import UIKit

class GreetingsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var welcomeLabel: UILabel!
    
    //MARK: - Properties
    var welcomeText = "Welcome,"
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = welcomeText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let loginVC = segue.destination as! ViewController
        loginVC.loginTextField.text = nil
        loginVC.passwordTextField.text = nil
    }
}
