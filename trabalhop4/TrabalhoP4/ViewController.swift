import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var addServiceButton: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var servicesList = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.layer.masksToBounds = true
        mainTableView.layer.cornerRadius = 5
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        //context.delete(servicesList[0])
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        mainTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    // MARK: - TableView Delegate & DataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! MainTableViewCell
        let service = servicesList[indexPath.row]
        
        cell.cellTitleLabel.text = service.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: service.requestDate! as Date)
        cell.cellRequestDateLabel.text = formattedDate
        cell.cellRequestDateLabel.sizeToFit()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return servicesList.count
        
    }
    
    // swipe left for delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // apagar a task selecionada do array no core data
            let service = servicesList[indexPath.row]
            context.delete(service)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // voltar a fazer um fetch do core data atualizado
            getData()
        }
        // repopular a tabela sem a task apagada
        tableView.reloadData()
    }
    
    // fetch stored CoreData objects
    func getData() {
    
        do{
            servicesList = try context.fetch(Service.fetchRequest())
        }catch{
            print("Fetch request failed")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SingleRequestSegue" {
            let destinationVC = segue.destination as! SingleRequestViewController
            if let indexPath = self.mainTableView.indexPathForSelectedRow {
                let selectedService = servicesList[indexPath.row]
                destinationVC.currentService = selectedService
            }
        }
        
    }
    
    

}

