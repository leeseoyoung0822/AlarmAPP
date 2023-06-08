//
//  AlarmCell.swift
//  LoginAnimation
//
//  Created by 이서영 on 2023/05/24.
//

import UIKit

class AlarmCell: UITableViewCell {

    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var indexPath: IndexPath?
    var delegate: MainViewController?
    
    var isSwitchOn : Bool{
        return alarmSwitch.isOn
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        guard let indexPath = indexPath else { return }
        
        if sender.isOn {
            if let alarmDate = delegate?.alarms[indexPath.row] {
                delegate?.switchOn(at: alarmDate, indexPath: indexPath)
            }
        } else {
            delegate?.hideAlarmUI()
        }

    }
}
