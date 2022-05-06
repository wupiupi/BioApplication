/*
  Plan:
  1. IBOutlets
  2. Properties
  3. Life Cycle
  4. Methods
  5. Action
 */

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //MARK: - Properties
    let greetings = ["Hey, ", "Sup, ", "Yo, ", "Welcome back, ", "Hello there, ", "Your majesty, "]
    var login: String?
    var password: String?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        let greetingsVC = tabBarController.viewControllers?.first as! GreetingsViewController
        
        guard let login = login else { return }
        
        greetingsVC.welcomeText = greetings.randomElement()! + login + "!"
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.loginTextField:
            self.passwordTextField.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
    }
    
    private func configureTextFields() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        login == "Paul" && password == "123" ? true : false
    }
            
    //Alerts
    private func showLoginAlert() {
        let alert = UIAlertController(title: "Login",
                                      message: "Your login is Paul",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: .default))
        present(alert, animated: true)
    }
    private func showPasswordAlert() {
        let alert = UIAlertController(title: "Password",
                                      message: "Your password is 123",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        present(alert, animated: true)
    }
    private func showEnteringError() {
        let alert = UIAlertController(title: "Error",
                                      message: "Login or password is invalid",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: .destructive))
    }
    
    //MARK: - Action
    @IBAction func EnterButton(_ sender: Any) {
        guard let login = login, let password = password else { return }
        let _ = User.init(name: login, password: password)
    }
    
    //Here we recieve user login and password
    @IBAction func loginTextField(_ sender: Any) {
        login = loginTextField.text!
    }
    @IBAction func passwordTextField(_ sender: Any) {
        password = passwordTextField.text!
    }
    
    //Show our alerts with hints
    @IBAction func forgotLoginButton() {
        showLoginAlert()
    }
    @IBAction func forgotPasswordButton() {
       showPasswordAlert()
    }
    
    @IBAction func unwindToLoginScreen(_ sender: UIStoryboardSegue) {}
}

//MARK: - Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        textField.resignFirstResponder()
        return true
    }
}
