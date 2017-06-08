import UIKit
import CoreData

class NewServiceViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newServiceTitle: UITextField!
    @IBOutlet weak var newServiceSubject: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    // MARK: - Save action
    
    @IBAction func saveNewService(_ sender: Any) {
        
        if newServiceTitle.text != "" && newServiceSubject.text != "" {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
            let newService = Service(context: context)
            newService.title = newServiceTitle.text!
            newService.subject = newServiceSubject.text!
            newService.requestDate = Date() as NSDate
        
            //save to core data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            createAlert(titleText: "Alert", messageText: "Request saved successfully")
            
            newServiceTitle.text = ""
            newServiceSubject.text = ""
            
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
