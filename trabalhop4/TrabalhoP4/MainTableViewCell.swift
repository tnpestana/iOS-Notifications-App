import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellRequestDateLabel: UILabel!
    @IBOutlet weak var posterNameLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
