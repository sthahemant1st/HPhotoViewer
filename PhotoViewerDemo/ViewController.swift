//
//  ViewController.swift
//  PhotoViewerDemo
//
//  Created by Hemant Shrestha on 24/08/2022.
//

import UIKit
import PhotoViewer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentPhotoViewer()
    }

    private func presentPhotoViewer() {
        PhotoViewer.shared.present(
            for: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg")!,
            errorImage: UIImage(named: "error"),
            presenter: self
        )
    }

}

