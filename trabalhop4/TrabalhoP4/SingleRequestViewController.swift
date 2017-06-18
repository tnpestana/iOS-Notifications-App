import UIKit

class SingleRequestViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    @IBOutlet weak var notificationDateText: UITextView!
    
    var currentRequest = Service()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.title = currentRequest.requestTitle
        
        // Round corners
        descriptionText.layer.masksToBounds = true
        descriptionText.layer.cornerRadius = 5
        dateText.layer.masksToBounds = true
        dateText.layer.cornerRadius = 5
        notificationDateText.layer.masksToBounds = true
        notificationDateText.layer.cornerRadius = 5
        

        descriptionText.text = currentRequest.requestDescription
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        var formattedDate = dateFormatter.string(from: currentRequest.requestDate! as Date)
        dateText.text = formattedDate
        dateText.sizeToFit()
        formattedDate = dateFormatter.string(from: currentRequest.notificationDate! as Date)
        notificationDateText.text = formattedDate
        notificationDateText.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Dismiss action
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
