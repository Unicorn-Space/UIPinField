import UIKit
import UIPinField

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let pinField = UIPinField.UIPinFeild()
        pinField.backgroundColor = .clear
        
        pinField.digitsCount = 4
        pinField.digitCellsSelectionColor = .lightGray
        pinField.digitCellsFillColor = .lightGray
                
        pinField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinField)
        
        let constraints = [
            pinField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pinField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            pinField.heightAnchor.constraint(equalToConstant: 72)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }


}

