//
//  Location.swift
//  MemsGame
//
//  Created by user163537 on 6/14/20.
//  Copyright © 2020 NaorFarag. All rights reserved.
//

import Foundation

class Location : Codable {
    
    var lat : Double = 0
    var lng : Double = 0
    
    init(){
        
    }
    init(lat: Double, lng: Double){
        self.lat = lat
        self.lng = lng
    }
    
    
}
