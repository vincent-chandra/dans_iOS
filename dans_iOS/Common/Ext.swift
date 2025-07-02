//
//  Ext.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class FeedListItem {
    static let sharedInstance = FeedListItem()
    var feedList = [FeedEntityList]()
}

extension UIImageView {
    func loadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let activityView = UIActivityIndicatorView(style: .large)
        self.addSubview(activityView)
        activityView.frame = self.bounds
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.startAnimating()
        
        // Show cached image if available
        if let cachedImage = ImageCache.shared.image(for: url) {
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }

            if let data = data, error == nil {
                let image = UIImage(data: data)?.jpegData(compressionQuality: 0.0)
                ImageCache.shared.save(UIImage(data: image ?? Data()) ?? UIImage(imageLiteralResourceName: "camera"), for: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: image ?? Data())
                }
            } else {
                return
            }
        }.resume()
    }
}
