//
//  MainViewController.swift
//  LoginAnimation
//
//  Created by 이서영 on 2023/05/23.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import FBSDKLoginKit
import FBSDKCoreKit


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bellImageView: UIImageView!
    @IBOutlet weak var stopButton: UIButton!
    
    var userInfo: String?
    var alarms : [Date] = []
    
    // 이미지를 표시할 타이머
    var imageDisplayTimer: Timer?
    
    // 알람 설정 AlarmViewController에서 돌아오는 segue를 처리하는 메서드.
    // AlarmViewController에서 설정한 알람을 가져와 alarms 배열에 추가한 후 테이블 뷰를 갱신함.
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {
        // segue의 원본 ViewController를 AlarmViewController로 변환하고, 설정된 알람이 있는지 확인함.
        guard let sourceViewController = segue.source as? AlarmViewController,
              let alarm = sourceViewController.alarm else { return }
        
        // 설정된 알람을 alarms 배열에 추가함.
        alarms.append(alarm)
        // 테이블 뷰를 갱신하여 새 알람을 표시함.
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.text = userInfo
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
       cell.indexPath = indexPath
       cell.delegate = self
       
       let alarm = alarms[indexPath.row]
       
       let formatter = DateFormatter()
       formatter.dateFormat = "a hh:mm"
       let alarmString = formatter.string(from: alarm)
       
       let dateComponents = alarmString.components(separatedBy: " ")
       if dateComponents.count == 2{
           cell.ampmLabel.text = dateComponents[0]
           cell.timeLabel.text = dateComponents[1]
       }
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // 스위치가 켜질 때 호출되는 메서드
    func switchOn(at date: Date, indexPath : IndexPath) {
        let now = Date()
        let calendar = Calendar.current
        
        // 현재 시간과 알람 시간 사이의 차이를 시, 분, 초 단위로 계산
        let components = calendar.dateComponents([.hour, .minute, .second], from: now, to: date)
        
        // 알람이 울릴 때까지 남은 시간을 초 단위로 계산
        let secondsToAlarm = components.hour! * 3600 + components.minute! * 60 + components.second!
        
        imageDisplayTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(secondsToAlarm), repeats: false) { timer in
            DispatchQueue.main.async {
                // 해당 셀의 스위치 상태를 확인하고 스위치가 켜져있는 경우에만 알람을 울립니다.
                if let cell = self.tableView.cellForRow(at: indexPath) as? AlarmCell, cell.isSwitchOn {
                    self.showAlarmUI()
                }
            }
        }
    }
    
    // 이미지와 버튼을 표시하고 테이블 뷰를 어둡게 하는 메서드
    func showAlarmUI() {
        bellImageView.isHidden = false
        stopButton.isHidden = false

        // 테이블 뷰를 어둡게 합니다 (50% 투명도)
        tableView.alpha = 0.5
        
        
    }
    
    // 이미지와 버튼을 숨기고 테이블 뷰를 밝게 하는 메서드
    func hideAlarmUI() {
        bellImageView.isHidden = true
        stopButton.isHidden = true
        imageDisplayTimer?.invalidate()
        imageDisplayTimer = nil

        // 테이블 뷰를 원래대로 복구
        tableView.alpha = 1.0
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        bellImageView.layer.removeAllAnimations()
        
        hideAlarmUI()
    }
    

}
