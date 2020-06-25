//
//  MainViewController.swift
//  HW_10_NetRequest
//
//  Created by 1 on 20.06.2020.
//  Copyright © 2020 Anzhelika. All rights reserved.
//

import UIKit

enum UserActions: String, CaseIterable {
    
    case downloadImage = "Theme"
    case exampleAll = "Cartoon characters"
    case alamofireGet = "Alamofire GET"
    case alamofirePOST = "Alamofire POST"
    
}


enum URLExamples: String {
    case imageURL = "https://duckduckgo.com/i/39ce98c0.png"
    case jsonURL = "https://thesimpsonsquoteapi.glitch.me/quotes?count=300"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    
}

class MainViewController: UICollectionViewController {
    
    let userActions = UserActions.allCases
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCellCollectionViewCell
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "ShowImage", sender: nil)
        case .exampleAll: performSegue(withIdentifier: "AllHeroes", sender: nil)
        case .alamofireGet: performSegue(withIdentifier: "AlamofireGet", sender: nil)
        case .alamofirePOST: performSegue(withIdentifier: "AlamofirePost", sender: nil)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "ShowImage" {
            
            let allHeroesVС = segue.destination as! AllHeroesTableViewController
            
            switch segue.identifier {
            case "AllHeroes": allHeroesVС.fetchDataNew()
            case "AlamofireGet": allHeroesVС.alamofireGetButtonPressed()
            case "AlamofirePost": allHeroesVС.alamofirePostButtonPressed()
            default: break
            }
        }
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

