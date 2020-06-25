//
//  AllHeroes.swift
//  HW_10_NetRequest
//
//  Created by 1 on 21.06.2020.
//  Copyright © 2020 Anzhelika. All rights reserved.
//

struct Hero: Decodable {
    var quote: String?
    var character: String?
    var image: String?
    
    
    init (dictHero: [String: Any]) {
        quote = dictHero["quote"] as? String
        character = dictHero["character"] as? String
        image = dictHero["image"] as? String
    }
    
static func getHeroes(from value: Any) -> [Hero]? {
        guard let value = value as? [[String: Any]] else { return nil }
        return value.compactMap { Hero(dictHero: $0) }
    }
    
}

 
