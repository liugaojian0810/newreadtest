//
//  HFCloudHomeUntilModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2021/2/1.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFCloudHomeUntilModel : Mappable {
    
    /**
     获取服务器时间
     model->date    string    服务器日期
     model->time    string    服务器时间
     */
    var date: String = ""
    var time: String = ""
    
    /**
     根据日期获取月份周数
     model->week    int    周数
     */
    var week: Int = 0
    
    
    /**
     获取年级列表
     model->grId    string    年级id
     model->grName    string    年级名称
     */
    var tId: String = ""
    var tName: String = ""
    
    
    /**
     获取幼儿园年级列表
     model->grId    string    年级基础业务id
     model->grName    string    年级业务名称
     model->kgrId    string    幼儿园年级业务id
     model->kgrRemarkName    string    年级备注名称
     */
    var grName: String = ""
    var grId: String = ""
    var kgrId: String = ""
    var kgrRemarkName: String = ""
    
    
    /**
     班级信息列表
     model->clId    string    班级业务id
     model->kiId    string    幼儿园业务id
     model->clName    string    班级名称
     model->grId    string    年级基础业务id
     model->grName    string    年级业务名称
     model->kgrId    string    幼儿园年级业务id
     model->kgrRemarkName    string    年级备注名称
     */
    var clName: String = ""
    var kiId: String = ""
    var clId: String = ""
    //    var grName: String = ""
    //    var grId: String = ""
    //    var kgrId: String = ""
    //    var kgrRemarkName: String = ""
    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        date    <- map["date"]
        time    <- map["time"]
        week    <- map["week"]
        
        tId    <- map["tId"]
        tName    <- map["tName"]
        grName    <- map["grName"]
        grId    <- map["grId"]
        kgrId    <- map["kgrId"]
        kgrRemarkName    <- map["kgrRemarkName"]
        clName    <- map["clName"]
        kiId    <- map["kiId"]
        clId    <- map["clId"]
    }
    
}
