//
//  Extensions.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//


import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                self.image = UIImage(named: "PlaceholderImage")
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
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
