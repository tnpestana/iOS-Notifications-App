import UIKit

class SingleRequestViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    @IBOutlet weak var notificationDateText: UITextView!
    
    // Variavel que guarda a informação sobre o objeto recebido através da segue
    var currentRequest = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Associar o título apresentado na barra de navegação ao título da entrada a visualizar
        navBar.topItem?.title = currentRequest.requestTitle
        
        // Round corners
        descriptionText.layer.masksToBounds = true
        descriptionText.layer.cornerRadius = 5
        dateText.layer.masksToBounds = true
        dateText.layer.cornerRadius = 5
        notificationDateText.layer.masksToBounds = true
        notificationDateText.layer.cornerRadius = 5
        
        // Preencher os campos do viewController com as propriedades especificas da entrada a visualizar
        descriptionText.text = currentRequest.requestDescription
        
        // Utilizar o date formatter para transformar a propriedade de tipo Date numa String para apresentar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        
        // Formatar e apresentar a data em que a entrada foi criada
        var formattedDate = dateFormatter.string(from: currentRequest.requestDate! as Date)
        dateText.text = formattedDate
        dateText.sizeToFit()
        
        // Formatar e apresentar a data para que a notificação foi agendada
        formattedDate = dateFormatter.string(from: currentRequest.notificationDate! as Date)
        notificationDateText.text = formattedDate
        notificationDateText.sizeToFit()
        
        // Make textViews non editable
        descriptionText.isEditable = false
        dateText.isEditable = false
        notificationDateText.isEditable = false
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
