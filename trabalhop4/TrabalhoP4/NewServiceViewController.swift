import UIKit
import CoreData
import UserNotifications

class NewServiceViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newServiceTitle: UITextField!
    @IBOutlet weak var newServiceDescription: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var currentRequest: Service?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tornar este view controler num delegate do notification center
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        // TextView com Rounded Corners
        newServiceDescription.clipsToBounds = true
        newServiceDescription.layer.cornerRadius = 5
        
        if currentRequest != nil {
            datePicker.date = (currentRequest?.notificationDate)! as Date
            newServiceTitle.text = currentRequest?.requestTitle
            newServiceDescription.text = currentRequest?.requestDescription
        }
        else {
            let now = datePicker.date
            datePicker.minimumDate = now
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    // MARK: - Save action
    
    @IBAction func saveNewService(_ sender: Any) {
        
        if newServiceTitle.text != "" && newServiceDescription.text != "" {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let selectedDate = datePicker.date

            // caso seja um novo request
            if currentRequest == nil {
                let newService = Service(context: context)
                newService.requestTitle = newServiceTitle.text!
                newService.requestDescription = newServiceDescription.text!
                newService.requestDate = Date() as NSDate
                newService.notificationDate = selectedDate as NSDate
            }
            // caso seja ediçao de um request existente
            else {
                var titles: [String] = []
                titles.append(currentRequest!.requestTitle!)
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [titles[0]])
                titles.removeAll()
                currentRequest?.requestTitle = newServiceTitle.text!
                currentRequest?.requestDescription = newServiceDescription.text!
                currentRequest?.requestDate = Date() as NSDate
                currentRequest?.notificationDate = selectedDate as NSDate
            }
            
            // notifications
            let calendar = Calendar(identifier: .gregorian)
            // separar a data em componentes (mes, dia, hora, etc) e guardar na constante 'components'
            let components = calendar.dateComponents(in: .current, from: selectedDate)
            // criar uma nova instancia de DateComponents que guarda apenas a informaçao que nos sera necessaria
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            // criar um trigger recorrendo a informaçao guardada em newComponents
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            // costumizar a notificaçao criada
            let content = UNMutableNotificationContent()
            content.title = newServiceTitle.text!
            content.body = newServiceDescription.text!
            content.sound = UNNotificationSound.default()
            // criar um request de notificaçao
            let request = UNNotificationRequest(identifier: newServiceTitle.text!, content: content, trigger: trigger)
            // adicionar o request criado ao centro de notificaçoes
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Error: \(error)")
                }
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
    
    
    // MARK: - Dismiss action
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
            dismiss(animated: true, completion: nil)
        
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


// EXTENSION
// adotar o protocolo notificationcenterdelegate atraves de uma extension
// faz-se isto para ser possivel receber push notifications em foreground
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

