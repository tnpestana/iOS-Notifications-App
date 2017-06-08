import UIKit

class SingleRequestViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    
    var currentService = Service()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Labels com round corners
        titleText.layer.masksToBounds = true
        titleText.layer.cornerRadius = 5
        descriptionText.layer.masksToBounds = true
        descriptionText.layer.cornerRadius = 5
        dateText.layer.masksToBounds = true
        dateText.layer.cornerRadius = 5
        

        titleText.text = currentService.requestTitle
        descriptionText.text = currentService.requestDescription
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: currentService.requestDate! as Date)
        dateText.text = formattedDate
        dateText.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
