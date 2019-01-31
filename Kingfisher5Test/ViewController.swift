//
//  ViewController.swift
//  Kingfisher5Test
//
//  Created by James Baker on 1/30/19.
//  Copyright © 2019 WDDG. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var kfRemoteImageView: AnimatedImageView!
    @IBOutlet weak var kfLocalImageView: AnimatedImageView!
    @IBOutlet weak var localImage: AnimatedImageView!
    private var downloadTask:DownloadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    
    private func setImage() {
        let remoteURL = URL(string: "https://cdn.vox-cdn.com/thumbor/Or0rhkc1ciDqjrKv73IEXGHtna0=/0x0:666x444/1200x800/filters:focal(273x193:379x299)/cdn.vox-cdn.com/uploads/chorus_image/image/59384673/Macaca_nigra_self-portrait__rotated_and_cropped_.0.jpg")!
        let localPath = Bundle.main.path(forResource: "monkey_selfie", ofType: "jpg")!
        let localURL = URL(fileURLWithPath:localPath)
    
        setKFImage(kfRemoteImageView, URL: remoteURL)
        setKFImage(kfLocalImageView, URL: localURL)
        localImage.image = UIImage(contentsOfFile: localPath)
    }
    
    private func setKFImage(_ target:AnimatedImageView, URL:URL) {
        target.kf.setImage(with: URL) { result in
            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
            switch result {
            case .success(let value):
                // The image was set to image view:
                print(value.image)
                
                // From where the image was retrieved:
                // - .none - Just downloaded.
                // - .memory - Got from memory cache.
                // - .disk - Got from disk cache.
                print(value.cacheType)
                
                // The source object which contains information like `url`.
                print(value.source)
                
            case .failure(let error):
                print(error) // The error happens
            }
        }
    }
}

