import UIKit
import CoreData

class NewServiceViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newServiceTitle: UITextField!
    @IBOutlet weak var newServiceDescription: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    var currentRequest: Service?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextView com Rounded Corners
        newServiceDescription.clipsToBounds = true
        newServiceDescription.layer.cornerRadius = 5
        
        if currentRequest != nil {
            newServiceTitle.text = currentRequest?.requestTitle
            newServiceDescription.text = currentRequest?.requestDescription
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    // MARK: - Save action
    
    @IBAction func saveNewService(_ sender: Any) {
        
        if newServiceTitle.text != "" && newServiceDescription.text != "" {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // caso seja um novo request
            if currentRequest == nil {
                let newService = Service(context: context)
                newService.requestTitle = newServiceTitle.text!
                newService.requestDescription = newServiceDescription.text!
                newService.requestDate = Date() as NSDate
            }
            // caso seja ediçao de um request existente
            else {
                currentRequest?.requestTitle = newServiceTitle.text!
                currentRequest?.requestDescription = newServiceDescription.text!
                currentRequest?.requestDate = Date() as NSDate
            }
            
            //save to core data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            createAlert(titleText: "Alert", messageText: "Request saved successfully")
            
            newServiceTitle.text = ""
            newServiceDescription.text = ""
            
        } else {
        
            createAlert(titleText: "Alert", messageText: "Please fill in all text fields")
            
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
