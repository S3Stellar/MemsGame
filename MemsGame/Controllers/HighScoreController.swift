//
//  HighScoreController.swift
//  MemsGame
//
//  Created by user163537 on 6/1/20.
//  Copyright © 2020 NaorFarag. All rights reserved.
//

import UIKit
import MapKit

class HighScoreController: UIViewController {
    
    @IBOutlet weak var SCORE_LIST_VIEW: UITableView!
    @IBOutlet weak var MAP_VIEW: MKMapView!
    var playerScores = [Player]()
    var converter: Converter = Converter()
    let cellReuseIdentifier = "cellView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCORE_LIST_VIEW.delegate = self
        SCORE_LIST_VIEW.dataSource = self
        
        self.playerScores = loadFromStorage()
        setMarkerOnMap(playerList: self.playerScores, index: 0)
    }
    
    
    func saveToStorage(playersList: [Player]){
        let defaults = UserDefaults.standard
        defaults.set(converter.playerListToJson(playerList: playersList), forKey: "score")
    }
    
    func loadFromStorage() -> [Player]{
        let defaults = UserDefaults.standard
        if let newList: [Player] = converter.jsonToPlayerList(jsonPlayerList: defaults.string(forKey: "score") ?? ""){
            return newList
        }
        return [Player]()
    }
    
    func updateListView (newPlayer: Player){
        var allPlayers = loadFromStorage()
        if allPlayers.count < 10 {
            allPlayers.append(newPlayer)
            saveToStorage(playersList: allPlayers.sorted(by: {$0.timeScore < $1.timeScore}))
        }else if(allPlayers.last!.timeScore > newPlayer.timeScore){
            allPlayers.remove(at: allPlayers.count - 1)
            allPlayers.append(newPlayer)
            saveToStorage(playersList: allPlayers.sorted(by: {$0.timeScore < $1.timeScore}))
        }
        self.playerScores = loadFromStorage()
    }
}

// MARK: - Table view
extension HighScoreController :UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : CustomEntryCell? = self.SCORE_LIST_VIEW.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CustomEntryCell
        cell?.topten_LBL_playername?.text = self.playerScores[indexPath.row].playerName
        cell?.topten_LBL_playertime?.text = String(format:"%02i:%02i", self.playerScores[indexPath.row].timeScore/60,self.playerScores[indexPath.row].timeScore % 60)
        cell?.topten_LBL_playerdate?.text = self.playerScores[indexPath.row].timePlayed
        if(cell == nil){
            cell = CustomEntryCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setMarkerOnMap(playerList: playerScores, index: indexPath.row)
    }
    
    
    // MARK: - MANAGE MAP
    func setMarkerOnMap(playerList: [Player], index: Int){
        if(!playerList.isEmpty){
            for player in playerList {
                let annontation = MKPointAnnotation()
                annontation.title = player.playerName
                annontation.coordinate = CLLocationCoordinate2D(latitude: player.location.lat , longitude: player.location.lng )
                MAP_VIEW.addAnnotation(annontation)
            }
            zoomIn(player: playerList[index])
        }
    }
    
    func zoomIn(player: Player){
        let zoomIn = CLLocationCoordinate2D(latitude: player.location.lat , longitude:player.location.lng  )
        let region = MKCoordinateRegion(center: zoomIn, latitudinalMeters: 800, longitudinalMeters: 800)
        MAP_VIEW.setRegion(region, animated: true)    }
    // MARK: - TESTING
    
    func clearStroateTestingOnly(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
    }
    
}

class CustomEntryCell: UITableViewCell {
    @IBOutlet weak var topten_LBL_playername: UILabel!
    @IBOutlet weak var topten_LBL_playertime: UILabel!
    @IBOutlet weak var topten_LBL_playerdate: UILabel!
}
