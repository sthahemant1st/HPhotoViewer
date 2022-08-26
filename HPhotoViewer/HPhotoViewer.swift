//
//  PhotoViewer.swift
//  PhotoViewer
//
//  Created by Hemant Shrestha on 24/08/2022.
//

import Foundation
import UIKit

public class HPhotoViewer {
    
    public static let shared = HPhotoViewer()
    
    /// A fuction which is used to present a viewController for previewing image
    /// - Parameters:
    ///   - photoUrl: URL of the photo you want to preview
    ///   - errorImage: FallBack image if given failed to open photoUrl
    ///   - presenter: ViewController which presents
    public func present(for photoUrl: URL, errorImage: UIImage?, presenter: UIViewController) {
        let storyBoard = UIStoryboard(name: "HPhotoViewer", bundle: Bundle.module)
        let vc = storyBoard.instantiateViewController(withIdentifier: PhotoViewerViewController.identifier)
        guard let vc = vc as? PhotoViewerViewController else { return }
        vc.url = photoUrl
        vc.errorImage = errorImage
        presenter.present(vc, animated: true)
    }
    
    /// Show photoViewer view form a navigation controller
    /// - Parameters:
    ///   - photoUrl: URL of the photo you want to preview
    ///   - errorImage: FallBack image if given failed to open photoUrl
    ///   - navigationController: navigation controller to show photoViewer
    public func show(for photoUrl: URL, errorImage: UIImage?, navigationController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "HPhotoViewer", bundle: Bundle.module)
        let vc = storyBoard.instantiateViewController(withIdentifier: PhotoViewerViewController.identifier)
        guard let vc = vc as? PhotoViewerViewController else { return }
        vc.url = photoUrl
        vc.errorImage = errorImage
        navigationController.pushViewController(vc, animated: true)
    }
}
