import UIKit
import CoreData

class NewServiceViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newServiceTitle: UITextField!
    @IBOutlet weak var newServiceDescription: UITextView!
    @IBOutlet weak var addButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextView com Rounded Corners
        newServiceDescription.clipsToBounds = true
        newServiceDescription.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    // MARK: - Save action
    
    @IBAction func saveNewService(_ sender: Any) {
        
        if newServiceTitle.text != "" && newServiceDescription.text != "" {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
            let newService = Service(context: context)
            newService.requestTitle = newServiceTitle.text!
            newService.requestDescription = newServiceDescription.text!
            newService.requestDate = Date() as NSDate
        
            //save to core data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            createAlert(titleText: "Alert", messageText: "Request saved successfully")
            
            newServiceTitle.text = ""
            newServiceDescription.text = ""
            
        } else {
        
            createAlert(titleText: "Alert", messageText: "Please fill all fields")
            
        }
        
    }
    
    
    // MARK: - Alert definition
    
    func createAlert(titleText: String, messageText: String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }

}
