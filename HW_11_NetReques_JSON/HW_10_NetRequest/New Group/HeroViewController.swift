//
//  HeroViewController.swift
//  HW_10_NetRequest
//
//  Created by 1 on 21.06.2020.
//  Copyright © 2020 Anzhelika. All rights reserved.
//

import UIKit

class HeroViewController: UIViewController {
    
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var detailItem: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        if let detail = detailItem {
            if let label = descriptionLabel {
                label.text = detail.quote
            }
        }
        if let name = detailItem {
            if let label = heroName {
                label.text = name.character
            }
        }
        
        DispatchQueue.main.async {
            guard let stringURL = self.detailItem?.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
                
            }
        }
    }
}

