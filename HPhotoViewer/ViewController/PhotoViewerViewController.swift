//
//  PhotoViewerViewController.swift
//  PhotoViewer
//
//  Created by Hemant Shrestha on 24/08/2022.
//

import UIKit

final class PhotoViewerViewController: UIViewController, Identifiable {

    // MARK: - Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageTopConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var url: URL!
    var errorImage: UIImage? = nil
    
    // MARK: - Private Properties
    private var imageSize: CGSize = .zero
    
    // MARK: - Computed Properties
    private var imageWidth: CGFloat {
        return imageSize.width
    }
    private var imageHeight: CGFloat {
        return imageSize.height
    }
    private var heightToWidth: Double {
        return Double(imageHeight) / Double(imageWidth)
    }
    private var widthToHeight: Double {
        return Double(imageWidth) / Double(imageHeight)
    }
    private var isPotrateImage: Bool {
        return imageHeight > imageWidth
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 6.0
        configureViews()
        fetchImage()
    }
    
    private func configureViews() {
//        activityIndicator.hidesWhenStopped = true
    }
    
    private func fetchImage() {
        activityIndicator.startAnimating()
        let task = URLSession.shared.downloadTask(with: url) { url, response, error in
            defer {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.configureImageAndScrollView()
                }
                
            }
            if error.hasValue {
                self.imageView.image = self.errorImage
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
            else {
                self.imageView.image = self.errorImage
                return
            }
            
            guard let url = url, let image = UIImage(contentsOfFile: url.path) else {
                self.imageView.image = self.errorImage
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
        task.resume()
    }
    
    private func configureImageAndScrollView() {
        imageSize = imageView.image!.size
        
        imageHeightConstraint.constant = imageHeight
        imageWidthConstraint.constant = imageWidth
        view.layoutIfNeeded()
        
        let xZoom = view.bounds.width / imageWidth
        let yZoom = view.bounds.height / imageHeight
        
        if xZoom < yZoom {
            scrollView.minimumZoomScale = xZoom
            scrollView.zoomScale = xZoom
        } else {
            scrollView.minimumZoomScale = yZoom
            scrollView.zoomScale = yZoom
        }
    }
}

extension PhotoViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        cofigureConstraintsAccordingToZoomScale(scrollView)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        cofigureConstraintsAccordingToZoomScale(scrollView)
    }
    
    private func cofigureConstraintsAccordingToZoomScale(_ scrollView: UIScrollView) {
        let zoomScale = scrollView.zoomScale
        
        let topValue = (scrollView.bounds.height - imageView.bounds.height * zoomScale) / 2
        if topValue >= 0 {
            imageTopConstraint.constant = topValue
        }
        
        let leadingValue = (scrollView.bounds.width - imageView.bounds.width * zoomScale ) / 2
        if leadingValue >= 0 {
            imageLeadingConstraint.constant = leadingValue
        }
    }
}
