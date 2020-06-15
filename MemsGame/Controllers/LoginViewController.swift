//
//  LoginViewController.swift
//  MemsGame
//
//  Created by user163537 on 6/1/20.
//  Copyright © 2020 NaorFarag. All rights reserved.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController {
    
    var locationManager: CLLocationManager!
    var converter : Converter = Converter()
    var userLocation : Location?
    var gameMode: String = "Easy"
    
    @IBOutlet weak var NICKNAME_TEXT: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyBoard()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    @IBAction func modeButtons(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            gameMode = "Easy"
        }
        else if sender.selectedSegmentIndex == 1 {
            gameMode = "Hard"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play"{
            let destination = segue.destination as! GameController
            destination.player.playerName = NICKNAME_TEXT.text!
            destination.player.timePlayed = converter.dateFormatter(date: Date())
            destination.player.location = userLocation ?? Location()
            destination.selectedGameMode = gameMode
        }
        if segue.identifier == "highscore" {
            //let destination = segue.destination as! HighScoreController
        }
    }
}

// MARK: - LOCATION HANDLING
extension LoginViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = Location(lat: location.coordinate.latitude,lng: location.coordinate.longitude)
            print("Location received")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
}

// MARK: - KEYBOARD HANDLING
extension LoginViewController {
    func hideKeyBoard() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissKeyBoard))
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
}
