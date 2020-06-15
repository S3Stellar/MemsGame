//
//  Player.swift
//  MemsGame
//
//  Created by user163537 on 6/14/20.
//  Copyright © 2020 NaorFarag. All rights reserved.
//

import Foundation

class Player : Codable {
    var playerName: String = ""
    var timePlayed: String = ""
    var timeScore : Int = 0
    var location: Location = Location()
    
    init() {
    }
    
    init(playerName: String, playerScore: Int, playerPlayDate: String, location: Location){
        self.playerName = playerName
        self.timeScore = playerScore
        self.timePlayed = playerPlayDate
        self.location = location
    }
}
