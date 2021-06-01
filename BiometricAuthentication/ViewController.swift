import UIKit
import LocalAuthentication

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authenticate", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton()
    {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            let reason = "Please authenticate with touch ID!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async
                {
                    guard success, error == nil else {
                        // Failure
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                    // Success, show other screen
                    let vc = UIViewController()
                    vc.title = "Welcome!"
                    vc.view.backgroundColor = .systemBlue
                    self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            }
        }
        else
        {
            // Cannot use
            let alert = UIAlertController(title: "Unavailable", message: "You cannot use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
