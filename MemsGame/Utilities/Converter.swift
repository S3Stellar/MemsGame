//
//  Converter.swift
//  MemsGame
//
//  Created by user163537 on 6/14/20.
//  Copyright © 2020 NaorFarag. All rights reserved.
//

import Foundation

class Converter {
    
    func playerListToJson(playerList: [Player]) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(playerList)
        let jsonString: String = String(data: data, encoding: .utf8)!
        return jsonString
    }
    
    func jsonToPlayerList(jsonPlayerList: String) -> [Player]? {
        let decoder = JSONDecoder()
        if jsonPlayerList == "" {
            return [Player]()
        } else {
            let data: [Player]
            let convertedData: Data = jsonPlayerList.data(using: .utf8)!
            do {
                data = try decoder.decode([Player].self,from: convertedData)
            } catch {
                return [Player]()
            }
            return data
        }
    }
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: date)
        
    }
}
