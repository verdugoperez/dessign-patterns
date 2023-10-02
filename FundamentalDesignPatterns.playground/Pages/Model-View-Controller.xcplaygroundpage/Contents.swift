/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Model-view-controller (MVC)
 - - - - - - - - - -
 ![MVC Diagram](MVC_Diagram.png)
 
 The model-view-controller (MVC) pattern separates objects into three types: models, views and controllers.
 
 **Models** hold onto application data. They are usually structs or simple classes.
 
 **Views** display visual elements and controls on screen. They are usually subclasses of `UIView`.
 
 **Controllers** coordinate between models and views. They are usually subclasses of `UIViewController`.
 
 ## Code Example
 */
import UIKit

// MARK: Model
public struct Address {
    public var street: String
    public var city: String
    public var state: String
    public var zipCode: String
}

// MARK: - View

public final class AddressView: UIView {
    @IBOutlet public var streetTextField: UITextField!
    @IBOutlet public var cityTextField: UITextField!
    @IBOutlet public var stateTextField: UITextField!
    @IBOutlet public var zipCodeTextField: UITextField!
}


// MARK: - Controller
public final class AddressViewController: UIViewController {
    public var address: Address? {
        didSet {
            // we call this function in case the address is set after viewDidLoad
            // in this example the model can tell the controller something has changed an that the views need updating
            updateViewFromAddress()
        }
    }
    
    public var addresView: AddressView! {
        /*
         is a computed property, as it only has a getter. It first checks isViewLoaded to prevent creating the view before the view controller is presented on screen. If isViewLoaded is true, it casts the view to an AddressView. To silence a warning, you surround this cast with parentheses.
         */
        guard isViewLoaded else { return nil}
        return (view as! AddressView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromAddress()
    }
    
    private func updateViewFromAddress() {
        guard let addressView = addresView, let address = address  else { return }
        
        addressView.streetTextField.text = address.street
        addressView.cityTextField.text = address.city
        addressView.stateTextField.text = address.state
        addressView.zipCodeTextField.text = address.zipCode
    }
    
    @IBAction public func updateAddressFromView(_ sender: AnyObject) {
        // Example of how the view can tell the controller something has changed, and the model needs updating.
        guard let street = addresView.streetTextField.text, !street.isEmpty,
        let city = addresView.cityTextField.text, !city.isEmpty,
        let state = addresView.stateTextField.text, !state.isEmpty,
        let zipCode = addresView.zipCodeTextField.text, !zipCode.isEmpty else {
            // TO-DO: show an error message or handle the error
            return
        }
        
        address = Address(street: street, city: city, state: state, zipCode: zipCode)
    }
}

