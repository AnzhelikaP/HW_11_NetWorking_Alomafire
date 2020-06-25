//
//  AllHeroesTableViewController.swift
//  HW_10_NetRequest
//
//  Created by 1 on 21.06.2020.
//  Copyright © 2020 Anzhelika. All rights reserved.
//

import UIKit
import Alamofire


class AllHeroesTableViewController: UITableViewController {
    
    let networkManager = NetworkManager.shared
    var heroes: [Hero] = []
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHero", for: indexPath)
        
        
        cell.textLabel?.text = heroes[indexPath.row].character
        
        
        // Этот блок команд - тормозит, но фото выводит
        DispatchQueue.global().async {
            guard let stringURL = self.heroes[indexPath.row].image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                cell.imageView?.image = UIImage(data: imageData)
                // эта команда постоянно выполняется, если раскомментировать. Так должно быть?
                //print("фото в ячейке \(String(self.heroes[indexPath.row].image ?? ""))")
            }
        }
        
        // Вопрос к Алексею: Почему у меня не работает эта команда?
        //   cell.imageView?.image = UIImage(named: heroes[indexPath.row].image ?? "")
        
        return cell
    }
    
    
    func fetchDataNew() {
        
    /*    Алексей, подскажите, почему мне не удалось использовать NetworkManager?
        
        NetworkManager.shared.fetchData(from: URLExamples.jsonURL.rawValue) { hero in
            DispatchQueue.main.async {
                self.hero = hero
                self.tableView.reloadData()
            }
        }
    }
    */
        
        
        guard let url = URL(string: URLExamples.jsonURL.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                self.heroes = try decoder.decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func alamofireGetButtonPressed() {
        
        AF.request(URLExamples.jsonURL.rawValue)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    self.heroes = Hero.getHeroes(from: value) ?? []
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    
    
    func alamofirePostButtonPressed() {
        let userData =
            ["quote":"Inflammable means flammable? What a country!",
             "character":"Dr. Nick",
             "image":"https://upload.wikimedia.org/wikipedia/ru/3/35/Dr._Nick_Riviera.png"]
        
        
        AF.request(URLExamples.postRequest.rawValue, method: .post, parameters: userData)
            .validate()
            .responseDecodable(of: Hero.self) { response in
                switch response.result {
                case .success(let course):
                    self.heroes.append(course)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HeroDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = heroes[indexPath.row] as Hero
                let controller = (segue.destination as! UINavigationController).topViewController as! HeroViewController
                controller.detailItem = object
            }
        }
    }
}
