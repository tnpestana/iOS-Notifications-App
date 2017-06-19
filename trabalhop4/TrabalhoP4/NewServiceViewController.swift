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
    var titles: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextView com Rounded Corners
        newServiceDescription.clipsToBounds = true
        newServiceDescription.layer.cornerRadius = 5
        
        // Verificar se foi recebida informação para conseguir dois comportamentos diferentes caso seja uma nova entrada ou uma edição
        if currentRequest != nil {
            
            // Caso seja recebida informação, carregar as propriedades do objeto para os campos correspondentes
            datePicker.date = (currentRequest?.notificationDate)! as Date
            newServiceTitle.text = currentRequest?.requestTitle
            newServiceDescription.text = currentRequest?.requestDescription
            
        }
        else {
            
            // Caso não seja recebida informação, o datePicker assume a hora presente e o resto dos campos são deixados em branco
            let now = datePicker.date
            datePicker.minimumDate = now
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    // MARK: - Save action
    
    @IBAction func saveNewService(_ sender: Any) {
        
        let currentDateTime = Date()
        
        // Verficar que todos os campos estão preenchidos antes de gravar a nova entrada
        if newServiceTitle.text != "" && newServiceDescription.text != "" && datePicker.date >= currentDateTime {
            
            // Guardar em variável a hora marcada no datePicker quando o botão é pressionado
            let selectedDate = datePicker.date

            // Caso seja um novo request
            if currentRequest == nil {
                
                // Aceder ao context do core data e criar uma nova entrada com os valores apresentados no viewController
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let newService = Service(context: context)
                newService.requestTitle = newServiceTitle.text!
                newService.requestDescription = newServiceDescription.text!
                newService.requestDate = Date() as NSDate
                newService.notificationDate = selectedDate as NSDate
                
            }
                
            // Caso seja ediçao de um request existente
            else {
                
                // Remover a notificação associada com ao objeto a editar (porque será criada uma nova, atualizada, ao pressionar o botão Add
                titles.append(currentRequest!.requestTitle!)
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [titles[0]])
                titles.removeAll()
                
                // Aceder ao objeto recebido através da segue e substituir os seus valores pelos apresentados no viewController
                currentRequest?.requestTitle = newServiceTitle.text!
                currentRequest?.requestDescription = newServiceDescription.text!
                currentRequest?.requestDate = Date() as NSDate
                currentRequest?.notificationDate = selectedDate as NSDate
            
            }
            
            // Criar uma notificação associada à entrada que se acaba de guardar
            // Definir o tipo de calendário utilizado
            let calendar = Calendar(identifier: .gregorian)
            
            // Separar a data em componentes (mes, dia, hora, etc) e guardar na constante 'components'
            let components = calendar.dateComponents(in: .current, from: selectedDate)
            
            // Criar uma nova instancia de DateComponents que guarda apenas a informaçao que nos será necessaria
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            
            // Criar um trigger recorrendo a informaçao guardada em newComponents
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            
            // Costumizar a notificaçao criada
            let content = UNMutableNotificationContent()
            content.title = newServiceTitle.text!
            content.body = newServiceDescription.text!
            content.sound = UNNotificationSound.default()
            
            // Criar um request para uma notificação com as caracteristicas especificadas anteriormente
            let request = UNNotificationRequest(identifier: newServiceTitle.text!, content: content, trigger: trigger)
            
            // Adicionar o request criado ao centro de notificaçoes
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Error: \(error)")
                }
            }
            
            //  Guardar no core data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // Alertar o utilizador de que a entrada e correspondente notificação foram criadas com sucesso
            createAlert(titleText: "Alert", messageText: "Request saved successfully")
            
            // Fazer um reset a todos os campos para o utilizador poder continuar a criar várias entradas de seguida
            newServiceTitle.text = ""
            newServiceDescription.text = ""
            datePicker.date = Date()
        }
        else {
            
            // Alertar o utilizador de que a entrada não foi criada porque nem todos os campos estão preenchidos ou com valores válidos
            createAlert(titleText: "Alert", messageText: "Please fill in all text fields and choose a future date and time")
            
        }
        
    }
    
    
    // MARK: - Dismiss action
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
            dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Alert definition
    // Método criado para facilitar a flexibilidade de alertas da aplicação
    func createAlert(titleText: String, messageText: String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }

}




