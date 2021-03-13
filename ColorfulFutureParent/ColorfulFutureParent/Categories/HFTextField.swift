//
//  HFTextField.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2021/1/20.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation


extension UITextField {
    
    /// 限制输入位数
    /// - Parameter wordNum: 限制字数： Int
   @objc public func limitInoutWord(_ wordNum: Int) {

        if (self.text?.length())! > wordNum && wordNum > 0 {
            self.text = self.text?.substring(to: wordNum)
        }
    }
    
    /// 限制输入位数
    /// - Parameter textField: 文本框
    /// - Parameter wordNum: 限制字数： Int
    @objc public static func limitInoutWord(_ textField: UITextField, _ wordNum: Int) {

        if (textField.text?.length())! > wordNum && wordNum > 0 {
            textField.text = textField.text?.substring(to: wordNum)
        }
    }
    
}



