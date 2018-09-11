//
//  ViewController.swift
//  CoreMotionExample
//
//  Created by Maxim Bilan on 1/21/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation
import CoreLocation

var player: AVAudioPlayer?

class TrackViewController: UIViewController, CLLocationManagerDelegate{
    
    let locManager = CLLocationManager()
    let name = "John"
    
    let x_label = UILabel()
    
    let SVM_thresh = 5.0
    let DSVM_thresh = 6.0
    
    var max = 0.0
    var ax_prev = 1.0
    var ay_prev = 1.0
    var az_prev = 1.0
    
    let fallDetect: FallDetect
    
    let motionManager = CMMotionManager()
    var timer: Timer!
    
    public init(FallDetect: FallDetect) {
        self.fallDetect = FallDetect
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.fallDetect = FallDetect()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = .green
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        navigationItem.title = "Fall Detection"
//        view.backgroundColor = .white
        x_label.translatesAutoresizingMaskIntoConstraints = false
        x_label.text = "Tracking"
        x_label.textAlignment = .center
        x_label.adjustsFontSizeToFitWidth = true
        view.addSubview(x_label)
        x_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        x_label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        x_label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        x_label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
//        sleep(5)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TrackViewController.update), userInfo: nil, repeats: !fallDetect.flag)
        
    }
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func update() {

        if let accelerometerData = motionManager.accelerometerData {
            let SVM = (pow(accelerometerData.acceleration.x,2) + pow(accelerometerData.acceleration.y,2) + pow(accelerometerData.acceleration.z,2)).squareRoot()
            
            let DSVM = pow((pow((accelerometerData.acceleration.x - ax_prev),2) + pow((accelerometerData.acceleration.y - ay_prev),2) + pow((accelerometerData.acceleration.z - az_prev),2)), 0.5)
            
            ax_prev = accelerometerData.acceleration.x
            ay_prev = accelerometerData.acceleration.y
            az_prev = accelerometerData.acceleration.z
            
            var currentLocation: CLLocation!
            
            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                
                currentLocation = locManager.location
                
            }
            
//            print(currentLocation)
            
            if (SVM > SVM_thresh) {
                DispatchQueue.main.async {
                    super.view.backgroundColor = .red
                    self.x_label.text = "You have fallen!"
                }

                self.fallDetect.flag = true
                print("hi")
                let date = Date()
                let calendar = Calendar.current
                var hour = calendar.component(.hour, from: date)
                var amPM = "AM"
                if (hour > 12) {
                    amPM = "PM"
                    hour = hour - 12
                }
                let minutes = calendar.component(.minute, from: date)
                var hString = String(hour)
                var mString = String(minutes)
                if (hour < 10) {
                    hString = "0" + hString
                }
                
                if (minutes < 10) {
                    mString = "0" + mString
                }
                
                
                // Define server side script URL
                let scriptUrl = "https://immense-caverns-26836.herokuapp.com/text?to=17818129215&userName=\(name)&time=\(hString):\(mString)\(amPM)&userPhone=17818129215&latitude=\(currentLocation.coordinate.latitude)&longitude=\(currentLocation.coordinate.longitude)"
                // Add one parameter
                //            let urlWithParams = scriptUrl + "?userName=\(userNameValue!)"
                // Create NSURL Ibject
                let myUrl = NSURL(string: scriptUrl);
                
                // Creaste URL Request
                let request = NSMutableURLRequest(url:myUrl! as URL);
                
                // Set request HTTP method to GET. It could be POST as well
                request.httpMethod = "GET"
                
                // Excute HTTP Request
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    data, response, error in
                    
                    // Check for error
                    if error != nil
                    {
                        print("error=\(error)")
                        return
                    }
                }
                
                task.resume()
                
                playSound()
            }
            
//            // Define server side script URL
//            let scriptUrl = "https://immense-caverns-26836.herokuapp.com/acceleration?svm=\(SVM)&dsvm=\(DSVM)"
//            // Add one parameter
////            let urlWithParams = scriptUrl + "?userName=\(userNameValue!)"
//            // Create NSURL Ibject
//            let myUrl = NSURL(string: scriptUrl);
//
//            // Creaste URL Request
//            let request = NSMutableURLRequest(url:myUrl! as URL);
//
//            // Set request HTTP method to GET. It could be POST as well
//            request.httpMethod = "GET"
//
//            // Excute HTTP Request
//            let task = URLSession.shared.dataTask(with: request as URLRequest) {
//                data, response, error in
//
//                // Check for error
//                if error != nil
//                {
//                    print("error=\(error)")
//                    return
//                }
//            }
//
//            task.resume()
        }
    }
}
