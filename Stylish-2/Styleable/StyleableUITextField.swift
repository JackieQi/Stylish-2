//
//  StyleableUITextField.swift
//  Stylish-2
//
//  Created by Piotr Gawlowski on 22/05/2017.
//  Copyright © 2017 Piotr Gawlowski. All rights reserved.
//

import UIKit

struct UITextFieldPropertySet : DynamicStylePropertySet {
    var propertySet: Dictionary<String, Any> = UITextField().retriveDynamicPropertySet()
}

extension StyleClass {
    var UITextField:UITextFieldPropertySet { get { return self.retrieve(propertySet: UITextFieldPropertySet.self) } set { self.register(propertySet: newValue) } }
}

@IBDesignable class StyleableUITextField: UITextField, Styleable {
    class var StyleApplicators: [StyleApplicator] {
        return StyleableUIView.StyleApplicators + StyleableUIFont.StyleApplicators + [{
            (style:StyleClass, target:Any) in
            if let textField = target as? UITextField {
                for (key, value) in style.UITextField.propertySet {
                    if !(value is NSNull) {
                        switch key {
                        case "background":
                            if value is UIImage {
                                textField.background = value as? UIImage
                            } else if value is UIColor {
                                textField.background = UIImage.from(color: value as! UIColor)
                            }
                            break
                        default:
                            textField.setStyleProperties(value: value, key: key)
                        }
                    }
                }
            }
            }]
    }
        
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
    
    override func prepareForInterfaceBuilder() {
        showErrorIfInvalidStyles()
    }

}
