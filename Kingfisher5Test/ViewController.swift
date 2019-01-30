//
//  ViewController.swift
//  Kingfisher5Test
//
//  Created by James Baker on 1/30/19.
//  Copyright © 2019 WDDG. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let filename:String? = "angry"
    private var downloadTask:DownloadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setWebP()
    }

    func pngPlaceholderLocationForFile(_ file:String, tones:Bool) -> String {
        return file
    }
    
    func webpLocationForFile(_ file:String, tones:Bool) -> String {
        return file
    }

    private func __setWebP() {
        let currentFile = self.filename!
        if let path = Bundle.main.path(forResource: self.pngPlaceholderLocationForFile(currentFile, tones:false), ofType: "png") {
            let url = URL(fileURLWithPath: path)
            self.downloadTask = ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) {
                [currentFile] result in
                DispatchQueue.main.async {
                    print("placing webp")
                    switch result {
                    case .success(let value):
                        print("Image: \(value.image)")
                        self.imageView.image = value.image
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    private func setWebP() {
        if let path = Bundle.main.path(forResource: self.pngPlaceholderLocationForFile(self.filename!, tones:false), ofType: "png") {
//            let url = URL(fileURLWithPath: path)
//            let url = URL(string: "https://cdn.vox-cdn.com/thumbor/Or0rhkc1ciDqjrKv73IEXGHtna0=/0x0:666x444/1200x800/filters:focal(273x193:379x299)/cdn.vox-cdn.com/uploads/chorus_image/image/59384673/Macaca_nigra_self-portrait__rotated_and_cropped_.0.jpg")
            let url = URL(fileURLWithPath:Bundle.main.path(forResource: "monkey_selfie", ofType: "jpg")!)
            
            imageView.kf.setImage(with: url)
            
//            imageView.kf.setImage(with: url) { result in
//                // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
//                switch result {
//                case .success(let value):
//                    // The image was set to image view:
//                    print(value.image)
//
//                    // From where the image was retrieved:
//                    // - .none - Just downloaded.
//                    // - .memory - Got from memory cache.
//                    // - .disk - Got from disk cache.
//                    print(value.cacheType)
//
//                    // The source object which contains information like `url`.
//                    print(value.source)
//
//                case .failure(let error):
//                    print(error) // The error happens
//                }
//            }
        }
    }
    
    private func _setWebP() {

        if let currentFile = self.filename {
            let tones:Bool? = false
            if let placeholderPath = Bundle.main.path(forResource: pngPlaceholderLocationForFile(currentFile, tones:tones!), ofType: "png") {
//                imageView.image = UIImage(contentsOfFile: placeholderPath)
                print("placing placeholder: \(placeholderPath)")
                DispatchQueue.global(qos: .background).async { [currentFilename = filename] in
                    
//                    if let path = Bundle.main.path(forResource: self.webpLocationForFile(currentFilename!, tones:tones!), ofType: "webp") {
                    if let path = Bundle.main.path(forResource: self.pngPlaceholderLocationForFile(currentFile, tones:tones!), ofType: "png") {
                        let url = URL(fileURLWithPath: path)
//                        let options:KingfisherOptionsInfo = [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)]
                        // skip the cache
                        //                                self.gifView.kf.cancelDownloadTask()
                        
                        
//                        self.gifView.kf.setImage(with: url, options:options, progressBlock: nil) { result in
//                            switch result {
//                            case .success(let value):
//                                print("Image: \(value.image). Got from: \(value.cacheType)")
//                            case .failure(let error):
//                                print("Error: \(error)")
//                            }
//                        }
                        
//                        self.downloadTask = ImageDownloader.default.downloadImage(with: url, options: options, progressBlock: nil) {
                        self.downloadTask = ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) {
                            [currentFilename] result in
                            DispatchQueue.main.async {
                                if (self.filename == currentFilename) {
                                    print("placing webp")
                                    switch result {
                                    case .success(let value):
                                        print("Image: \(value.image)")
                                        self.imageView.image = value.image
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }

                                } else {
                                    print("skip placing webp")
                                }
                            }
                        }
                    } else {
                        print("webp missing:\(self.filename ?? ":filename-invalid")")
                    }
                }
            } else {
                print("placeholder missing:\(filename)")
            }
        }
        
    }
    
}

