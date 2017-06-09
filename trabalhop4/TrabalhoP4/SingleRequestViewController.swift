import UIKit

class SingleRequestViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    
    var currentRequest = Service()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.title = currentRequest.requestTitle
        
        // Round corners
        descriptionText.layer.masksToBounds = true
        descriptionText.layer.cornerRadius = 5
        dateText.layer.masksToBounds = true
        dateText.layer.cornerRadius = 5
        

        descriptionText.text = currentRequest.requestDescription
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        let formattedDate = dateFormatter.string(from: currentRequest.requestDate! as Date)
        dateText.text = formattedDate
        dateText.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
