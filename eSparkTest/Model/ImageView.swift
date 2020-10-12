//
//  ImageView.swift
//  eSparkTest
//
//  Created by Arvydas Klimavicius on 2020-10-12.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            [ weak self ] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
