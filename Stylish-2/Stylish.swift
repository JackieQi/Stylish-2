//
//  Stylish.swift
//  Stylish-2.0
//
//  Created by Piotr Gawlowski on 08/05/2017.
//  Copyright © 2017 Piotr Gawlowski. All rights reserved.
//

import Foundation
import UIKit

struct Stylish {
    static var GlobalStylesheet:Stylesheet.Type? = nil {
        didSet {
            refreshAllStyles()
        }
    }
    
    static func refreshAllStyles() {
        for window in UIApplication.shared.windows {
            refreshStyles(for: window)
        }
    }
    
    static func refreshStyles(for view:UIView) {
        for subview in view.subviews {
            refreshStyles(for: subview)
        }
        if let styleable = view as? Styleable {
            var styleableView = styleable
            styleableView.stylesheet = styleable.stylesheet
        }
    }
}

// MARK: - Stylish Error View -

extension Stylish {
    static let ErrorViewTag = 7331
    
    class ErrorView:UIKit.UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        private func setup() {
            let context = CIContext()
            let stripesFilter = CIFilter(name: "CIStripesGenerator", withInputParameters: ["inputColor0" : CIColor(color: UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4)), "inputColor1" : CIColor(color: UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.6)), "inputWidth" : 2])!
            let stripes = context.createCGImage(stripesFilter.outputImage!, from: CGRect(origin: CGPoint.zero, size: CGSize(width: 32.0, height: 32.0)))
            let rotateFilter = CIFilter(name: "CIStraightenFilter", withInputParameters: ["inputImage" : CIImage(cgImage: stripes!), "inputAngle" : 2.35])!
            let rotated = context.createCGImage(rotateFilter.outputImage!, from: rotateFilter.outputImage!.extent)
            let stripesView = UIKit.UIView()
            stripesView.backgroundColor = UIColor(patternImage: UIImage(cgImage: rotated!))
            stripesView.frame = bounds
            addSubview(stripesView)
        }
    }
}
