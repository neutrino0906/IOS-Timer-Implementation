//
//  ViewController.swift
//  TimerApp
//
//  Created by Ground 2 on 15/03/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter = TimerPresenter()
    var interactor = TimerInteractor()
    
    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var circularBarContainerView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var timeTextView: UILabel!
    @IBOutlet var holdingTimeTextView: UILabel!
    @IBOutlet var speedButton: UIButton!
    
    var checkPointList = [String]()
    
    var circularBarView: CircularBarView!
    
    var holdTimer = Timer()
    var holdingTime = 60
    let duration: Float = 1860.0
    var currentProgress: Float = 1860.0
    var currentSeconds = 1860
    var currentSpeed = 1.0
    
    
    
    @IBAction func startButtonAction(_ sender: Any) {
        startButton.isEnabled = false
        resetButton.isEnabled = true
        speedButton.isEnabled = false
        pauseButton.isEnabled = true
        presenter.startTimer()
    }
    
    
    @IBAction func resetButtonAction(_ sender: Any) {
        pauseButton.setTitle("Pause", for: .normal)
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        speedButton.isEnabled = true
        presenter.resetTimer()
        checkPointList.removeAll()
        tableView.reloadData()
        timeTextView.text = "31:00"
    }
    
    
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        
        if(pauseButton.titleLabel?.text == "Pause"){
            pauseButton.setTitle("Resume", for: .normal)
            presenter.timerInvalidate()
            presenter.timerForLabelInvalidate()
        }else{
            pauseButton.setTitle("Pause", for: .normal)
            presenter.timerValidate()
        }
    }
    
    
    
    @objc func setLabel(){
        if(currentSeconds <= 0){
            currentSeconds = 1860
            presenter.timerForLabelInvalidate()
            return
        }
        currentSeconds-=1
        let (m,s) = secondsToMinutesSeconds(currentSeconds)
        timeTextView.text = String(format: "%02d:%02d", m,s)
        
        if((currentSeconds-60)%180==0){
            checkPointList.append("CheckPoint \(String(format: "%02d:%02d", m,s))")
            tableView.reloadData()
            presenter.timerInvalidate()
            presenter.timerForLabelInvalidate()
            pauseButton.isEnabled = false
            resetButton.isEnabled = false
            Timer.scheduledTimer(withTimeInterval: 60.0/currentSpeed, repeats: false, block: {
                _ in
                self.presenter.timerValidate()
                self.pauseButton.isEnabled = true
                self.resetButton.isEnabled = true
            })
            
            
            holdTimer = Timer.scheduledTimer(timeInterval: 1.0/currentSpeed, target: self, selector: #selector(holdForAMinute), userInfo: nil, repeats: true)
        }
    }
        
        
    @objc func holdForAMinute(){
        if(holdingTime == 0){
            holdingTime = 60
            holdTimer.invalidate()
            holdingTimeTextView.text = ""
        }else{
            holdingTime -= 1
            holdingTimeTextView.text = "Will Resume in: \(holdingTime)"
        }
    }
        
        @objc func setCircularBar()
        {
            if currentProgress <= 0
            {
                currentProgress = 1860.0
                presenter.timerInvalidate()
            }
            else{
            
                let progress = (currentProgress/duration)
                
                currentProgress -= Float(1.0)
                circularBarView.progressLayer.strokeEnd = CGFloat(progress)
            }
        }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.view = self
        interactor.view = self
        
        tableView.dataSource = self
        pauseButton.isEnabled = false
        resetButton.isEnabled = false
        timeTextView.text = "31:00"
        circularBarView = CircularBarView()
        addView(1.0)
        
        let popUpButtonClosure = { (action: UIAction) in
            switch action.title {
            case "1x":
                self.presenter.updateSpeed(1.0)
                self.currentSpeed = 1.0
            case "2x":
                self.presenter.updateSpeed(2.0)
                self.currentSpeed = 2.0
            case "5x":
                self.presenter.updateSpeed(5.0)
                self.currentSpeed = 5.0
            case "10x":
                self.presenter.updateSpeed(10.0)
                self.currentSpeed = 10.0
            default:
                self.presenter.updateSpeed(1.0)
                self.currentSpeed = 1.0
                }
            }
        
        var menuChildren: [UIMenuElement] = []
        menuChildren.append(UIAction(title: "1x", handler: popUpButtonClosure))
        menuChildren.append(UIAction(title: "2x", handler: popUpButtonClosure))
        menuChildren.append(UIAction(title: "5x", handler: popUpButtonClosure))
        menuChildren.append(UIAction(title: "10x", handler: popUpButtonClosure))
        
        speedButton.menu = UIMenu(children: menuChildren)
        speedButton.showsMenuAsPrimaryAction = true
        
    }
    
    func addView(_ progress: Float){
        
        circularBarView.createCircularPath(progress)
        
        circularBarView.center = circularBarContainerView.center
        
        view.addSubview(circularBarView)
        
    }
    
    
    func secondsToMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }


}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkPointList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CheckpointTableViewCell
        cell.checkpointTextView.text = checkPointList[indexPath.row]
        return cell
    }
    
    
}

