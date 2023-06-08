//
//  AlarmViewController.swift
//  LoginAnimation
//
//  Created by 이서영 on 2023/05/23.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timeLabel: UILabel!
    var alarm : Date?
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.white, forKey: "textColor")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))

    }
    @objc func cancelButtonTapped() {
        // Pop current ViewController and go back to the previous one
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm" // 원하는 시간 형식으로 설정
        let selectedTime = formatter.string(from: sender.date)
        timeLabel.text = selectedTime
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        alarm = datePicker.date
        
        performSegue(withIdentifier: "unwindToMainViewController", sender: self)
    }
}
