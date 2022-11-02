//
//  Extensions.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//


import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        let imageCache = NSCache<NSString, AnyObject>()

        contentMode = mode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let imageToCache = UIImage(data: data),
                      let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                      let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                      error == nil
                else {
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "PlaceholderImage")
                    }
                    return
                }
                DispatchQueue.main.async {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
            }.resume()
        }
    }
    
    func loadImageWith(url: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        self.downloaded(from: url, contentMode: mode)
    }
    
}

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
    }
}

extension UIViewController: ErrorHandling {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
