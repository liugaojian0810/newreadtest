//
//  HFAddBabyViewModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class HFAddBabyViewModel: NSObject {
    
    var addBabyDataModel: HFAddBabyDataModel?
    
    var dataArr: [[AnyObject]] = []
    
    override init() {
        super.init()
        
        var babyInfoArr: [AnyObject] = []
        
        let model00 = HFFormTextInputCellModel.init()
        model00.title = "宝宝姓名"
        model00.placeholder = "请输入宝宝姓名"
        babyInfoArr.append(model00)
        
        let model01 = HFFormTextInputCellModel.init()
        model01.title = "宝宝小名"
        model01.placeholder = "请输入宝宝小名"
        babyInfoArr.append(model01)
        
        let model02 = HFFormSelectCellModel.init()
        model02.title = "出生日期"
        model02.placeholder = "请选择"
        babyInfoArr.append(model02)
        
        let model03 = HFFormSelectCellModel.init()
        model03.title = "宝宝性别"
        model03.placeholder = "请选择"
        babyInfoArr.append(model03)
        
        let model04 = HFFormSelectCellModel.init()
        model04.title = "与宝宝关系"
        model04.placeholder = "请选择"
        babyInfoArr.append(model04)
        
        dataArr.append(babyInfoArr)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 选择的宝宝关系
    var relationModel: HFDictionaryInfoModel?
    // 选择的年级
    var selectGradeModel: HFGradeModel?
    // 选择的班级
    var selectClassModel: HFClassModel?
    
    /// 添加宝宝
    /// - Parameters:
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func addChild(successClosure: @escaping ()->(), failClosure: @escaping ()->()) -> Void {
        var parameters: [String : AnyObject] = addBabyDataModel?.toJSON() as! [String : AnyObject]
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AddInfoChildAPI, para: parameters, successed: { (response) in
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 年级班级编辑状态： 0、新增 1、不变 2、修改
    var cgType = 1
    
    /// 编辑宝宝
    /// - Parameters:
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func editChild(successClosure: @escaping ()->(), failClosure: @escaping ()->()) -> Void {
        var parameters:[String:AnyObject] = addBabyDataModel?.toJSON() as! [String : AnyObject]
        parameters["type"] = cgType as AnyObject
        
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.ChildPrtlInfoAPI, para: parameters, successed: { (response) in
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
}
