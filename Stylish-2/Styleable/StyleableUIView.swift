//
//  UIViewPropertySet.swift
//  Stylish-2.0
//
//  Created by Piotr Gawlowski on 08/05/2017.
//  Copyright © 2017 Piotr Gawlowski. All rights reserved.
//

import Foundation
import UIKit

struct UIViewPropertySet : DynamicStylePropertySet {
    var propertySet: Dictionary<String, Any> = UIView().retriveDynamicPropertySet() + CALayer().retriveDynamicPropertySet(prefix: "layer.")
}

extension StyleClass {
//    var UIView:UIViewPropertySet { get { return self.retrieve(propertySet: UIViewPropertySet.self) } set { self.register(propertySet: newValue) } }
}

 public class StyleableUIView : UIView, Styleable {
    
    class var StyleApplicator: [StyleApplicatorType : StyleApplicator] {
        return [.UIViewPropertySet : {
            (property:Property, target:Any) in
            if let view = target as? UIView, let key = property.propertyName, let propertySet = property.propertyValue {
                view.setStyleProperties(value: propertySet.value, key: key)
            }
        }]
    }

//    class var StyleApplicators:[StyleApplicator] {
//        return []
//        return [{
//            (style:StyleClass, target:Any) in
//            if let view = target as? UIView {
//                for (key, value) in style.UIView.propertySet {
//                    if !(value is NSNull) {
//                        view.setStyleProperties(value: value, key: key)
//                    }
//                }
//            }
//        }]
//    }
    
    @IBInspectable var styles:String = "" {
        didSet {
            parseAndApplyStyles()
        }
    }
    
    @IBInspectable var stylesheet:String = "" {
        didSet {
            parseAndApplyStyles()
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        showErrorIfInvalidStyles()
    }
}

