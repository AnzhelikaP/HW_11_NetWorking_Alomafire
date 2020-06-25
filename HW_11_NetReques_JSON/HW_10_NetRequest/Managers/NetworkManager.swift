//
//  NetworkManager.swift
//  HW_10_NetRequest
//
//  Created by 1 on 24.06.2020.
//  Copyright © 2020 Anzhelika. All rights reserved.
//

import Foundation


    
    class NetworkManager {
        
        static let shared = NetworkManager()
        
        private init() {}
        
        func fetchData(from urlString: String, with complition: @escaping (Hero) -> Void) {
            
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error { print(error); return }
                guard let data = data else { return }
                
                do {
                    let hero = try JSONDecoder().decode(Hero.self, from: data)
                    complition(hero)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
                
            }.resume()
        }
    }

