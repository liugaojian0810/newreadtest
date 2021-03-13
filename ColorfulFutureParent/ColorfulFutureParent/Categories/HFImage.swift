//
//  HFImage.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2021/1/20.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import UIKit

/// 默认头像设置
extension UIImage {
    /// 获取宝宝默认头像
        /// - Parameter sex: 性别
        /// - Returns: 图片
    static func getBabyHead(with sex: Int) -> UIImage {
        
        if sex == 1 {
            return UIImage(named: "default_icon_baby_man") ?? UIImage.getWith(.colorBg())
        }else if sex == 1 {
            return UIImage(named: "default_icon_baby_women") ?? UIImage.getWith(.colorBg())
        }else{
            return UIImage(named: "default_icon_baby_women") ?? UIImage.getWith(.colorBg())
        }
    }
    
    static func getParentOfFather() -> UIImage {
        UIImage(named: "default_icon_father") ?? UIImage.getWith(.colorBg())
    }
    
    static func getParentOfMother() -> UIImage {
        UIImage(named: "default_icon_mother") ?? UIImage.getWith(.colorBg())
    }
    /// 男宝宝
    /// - Returns: 图片
    static func babyMan() -> UIImage {
        
        return UIImage(named: "default_icon_baby_man") ?? UIImage.getWith(.colorBg())
    }
    /// 女宝宝
    /// - Returns: 图片
    static func babyWomen() -> UIImage {
        
        return UIImage(named: "default_icon_baby_women") ?? UIImage.getWith(.colorBg())
    }
    /// 园长男
    /// - Returns: 图片
    static func directorMan() -> UIImage {
        
        return UIImage(named: "default_icon_director_man") ?? UIImage.getWith(.colorBg())
    }
    /// 园长女
    /// - Returns: 图片
    static func directorWomen() -> UIImage {
        
        return UIImage(named: "default_icon_director_women") ?? UIImage.getWith(.colorBg())
    }
    /// 爸爸
    /// - Returns: 图片
    static func father() -> UIImage {
        
        return UIImage(named: "default_icon_father") ?? UIImage.getWith(.colorBg())
    }
    /// 妈妈
    /// - Returns: 图片
    static func mother() -> UIImage {
        
        return UIImage(named: "default_icon_mother") ?? UIImage.getWith(.colorBg())
    }
    /// 爷爷
    /// - Returns: 图片
    static func gradeMa() -> UIImage {
        
        return UIImage(named: "default_icon_grade_ma") ?? UIImage.getWith(.colorBg())
    }
    /// 奶奶
    /// - Returns: 图片
    static func gradePa() -> UIImage {
        
        return UIImage(named: "default_icon_grade_pa") ?? UIImage.getWith(.colorBg())
    }
    /// 男教师
    /// - Returns: 图片
    static func teacherMan() -> UIImage {
        
        return UIImage(named: "default_icon_teacher_man") ?? UIImage.getWith(.colorBg())
    }
    /// 女教师
    /// - Returns: 图片
    static func teacherWomen() -> UIImage {
        
        return UIImage(named: "default_icon_teacher_women") ?? UIImage.getWith(.colorBg())
    }
}
