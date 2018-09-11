//
//  HomeViewController.swift
//  Noti-Fall2
//
//  Created by Debanik Purkayastha on 9/8/18.
//  Copyright © 2018 Debanik Purkayastha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let greeting = UILabel()
    let fallNotif = UILabel()
    let dayCount = UILabel()
    let weekCount = UILabel()
    let monthCount = UILabel()
    let yearCount = UILabel()
    
    let FallCounter = FallCount()
    let fallDetect = FallDetect()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = UIColor(red:0.48, green:0.71, blue:0.82, alpha:1.0)
        
//        greeting.translatesAutoresizingMaskIntoConstraints = false
//        greeting.text = "Hello, John!"
        greeting.textColor = .white
        greeting.textAlignment = .center
        greeting.font = UIFont.boldSystemFont(ofSize: 30)
//        greeting.textAlignment = .center
//        greeting.adjustsFontSizeToFitWidth = true
//        view.addSubview(greeting)
//        greeting.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        greeting.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
//        greeting.heightAnchor.constraint(equalToConstant: 45).isActive = true
//        greeting.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        fallNotif.translatesAutoresizingMaskIntoConstraints = false
        fallNotif.text = "You have fallen: "
        fallNotif.textColor = .white
        fallNotif.textAlignment = .center
        fallNotif.font = UIFont.boldSystemFont(ofSize: 25)
        fallNotif.textAlignment = .center
        fallNotif.adjustsFontSizeToFitWidth = true
        view.addSubview(fallNotif)
        fallNotif.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fallNotif.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        fallNotif.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fallNotif.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        dayCount.translatesAutoresizingMaskIntoConstraints = false
        dayCount.text = String(FallCounter.dayCount) + " times today"
        dayCount.textColor = .white
        dayCount.textAlignment = .center
//        dayCount.font = UIFont.boldSystemFont(ofSize: 25)
        dayCount.textAlignment = .center
        dayCount.adjustsFontSizeToFitWidth = true
        view.addSubview(dayCount)
        dayCount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayCount.centerYAnchor.constraint(equalTo: fallNotif.bottomAnchor, constant: 20).isActive = true
        dayCount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dayCount.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        weekCount.translatesAutoresizingMaskIntoConstraints = false
        weekCount.text = String(FallCounter.weekCount) + " times this week"
        weekCount.textColor = .white
        weekCount.textAlignment = .center
        //        dayCount.font = UIFont.boldSystemFont(ofSize: 25)
        weekCount.textAlignment = .center
        weekCount.adjustsFontSizeToFitWidth = true
        view.addSubview(weekCount)
        weekCount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weekCount.centerYAnchor.constraint(equalTo: dayCount.bottomAnchor, constant: 20).isActive = true
        weekCount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        weekCount.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        monthCount.translatesAutoresizingMaskIntoConstraints = false
        monthCount.text = String(FallCounter.weekCount) + " times this week"
        monthCount.textColor = .white
        monthCount.textAlignment = .center
        //        dayCount.font = UIFont.boldSystemFont(ofSize: 25)
        monthCount.textAlignment = .center
        monthCount.adjustsFontSizeToFitWidth = true
        view.addSubview(monthCount)
        monthCount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        monthCount.centerYAnchor.constraint(equalTo: weekCount.bottomAnchor, constant: 20).isActive = true
        monthCount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        monthCount.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        yearCount.translatesAutoresizingMaskIntoConstraints = false
        yearCount.text = String(FallCounter.yearCount) + " times this year"
        yearCount.textColor = .white
        yearCount.textAlignment = .center
        //        dayCount.font = UIFont.boldSystemFont(ofSize: 25)
        yearCount.textAlignment = .center
        yearCount.adjustsFontSizeToFitWidth = true
        view.addSubview(yearCount)
        yearCount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yearCount.centerYAnchor.constraint(equalTo: monthCount.bottomAnchor, constant: 20).isActive = true
        yearCount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        yearCount.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        let proceedButton = UIButton()
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        proceedButton.addTarget(self, action: #selector(startTracking), for: .touchUpInside)
        proceedButton.setTitle("Start Tracking", for: .normal)
        proceedButton.backgroundColor = UIColor(red:0.00, green:0.37, blue:0.72, alpha:1.0)
        proceedButton.layer.cornerRadius = 20
        proceedButton.clipsToBounds = true
        self.view.addSubview(proceedButton)
        proceedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        proceedButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: view.frame.height / 10).isActive = true
        proceedButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        
        
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo4.png")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        imageview.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: view.frame.width/4.5).isActive = true
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageview.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        
        
        greeting.translatesAutoresizingMaskIntoConstraints = false
        greeting.text = "Hello, John!"
        greeting.textAlignment = .center
        greeting.adjustsFontSizeToFitWidth = true
        view.addSubview(greeting)
        greeting.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greeting.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        greeting.heightAnchor.constraint(equalToConstant: 50).isActive = true
        greeting.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (fallDetect.flag == true) {
            FallCounter.dayCount += 1
            FallCounter.weekCount += 1
            FallCounter.monthCount += 1
            FallCounter.yearCount += 1
            fallDetect.flag = false
        }
        
        dayCount.text = String(FallCounter.dayCount) + " times today"
        weekCount.text = String(FallCounter.weekCount) + " times this week"
        monthCount.text = String(FallCounter.monthCount) + " times this month"
        yearCount.text = String(FallCounter.yearCount) + " times this year"
    }
    
    @objc func startTracking(_ sender : UIButton) {
        self.navigationController!.pushViewController(TrackViewController(FallDetect: fallDetect), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
