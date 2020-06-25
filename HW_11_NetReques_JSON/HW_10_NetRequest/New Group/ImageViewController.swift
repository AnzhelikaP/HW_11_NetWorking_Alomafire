//
//  ImageViewController.swift
//  HW_10_NetRequest
//
//  Created by 1 on 21.06.2020.
//  Copyright © 2020 Anzhelika. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchImage()
    }
    
    private func fetchImage() {
        
        let stringURL = "https://duckduckgo.com/i/39ce98c0.png"
        
        guard let imageURL = URL(string: stringURL) else { return }
        
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            if let error = error { print(error); return }
            
            if let response = response { print(response) }
            
            if let data = data, let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}


