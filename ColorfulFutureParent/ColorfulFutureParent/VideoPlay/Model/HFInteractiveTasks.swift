//
//  HFInteractiveTasks.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2021/2/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

@objc
class HFEffectResult: NSObject, Mappable {
    
    /// configEffectResultList
    @objc var ceName: String = ""
    @objc var ceSelectType: Int = 0
    @objc var ceStageType: Int = 0
    @objc var ceDescribe: String = ""
    @objc var ceId: String = ""
    @objc var ceEffectUrl: String = ""
    @objc var ceDecibelType: Int = 0
    @objc var enableStatus: Int = 0
    @objc var sort: Int = 0
    @objc var updateTime: String = ""
    @objc var createTime: String = ""
    
    /// configVoiceResultList
    @objc var cvName: String = ""
    @objc var cvStageType: Int = 0
    @objc var cvDescribe: String = ""
    //    @objc var enableStatus: Int = 0
    @objc var cvId: String = ""
    @objc var cvVoiceUrl: String = ""
    //    @objc var updateTime: String = ""
    @objc var cvDecibelType: Int = 0
    @objc var cvSelectType: Int = 0
    //    @objc var createTime: String = ""
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// KVC
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("key:\(key)")
    }
    
    override func setNilValueForKey(_ key: String) {
        
    }
    
    func mapping(map: Map) {
        
        ceName    <- map["ceName"]
        ceSelectType    <- (map["ceSelectType"],IntTransform())
        ceStageType    <- (map["ceStageType"],IntTransform())
        ceDescribe    <- map["ceDescribe"]
        ceId    <- map["ceId"]
        ceEffectUrl    <- map["ceEffectUrl"]
        ceDecibelType    <- (map["ceDecibelType"],IntTransform())
        enableStatus    <- (map["enableStatus"],IntTransform())
        sort    <- (map["sort"],IntTransform())
        updateTime    <- map["updateTime"]
        createTime    <- map["createTime"]
        
        
        cvName    <- map["cvName"]
        cvStageType    <- (map["cvStageType"],IntTransform())
        cvDescribe    <- map["cvDescribe"]
        //    enableStatus    <- map["enableStatus"]
        cvId    <- map["cvId"]
        cvVoiceUrl    <- map["cvVoiceUrl"]
        //    updateTime    <- map["updateTime"]
        cvDecibelType    <- (map["cvDecibelType"],IntTransform())
        cvSelectType    <- (map["cvSelectType"],IntTransform())
        //    createTime    <- map["createTime"]
        
    }
}



@objc
class HFInteractiveTasks: NSObject, Mappable {
    
    
    @objc var name: String = ""
    @objc var type: Int = 0
    @objc var waitTime: Int = 0
    @objc var imgAnswerTrueIndex: Int = 0
    @objc var startTime: Int = 0
    @objc var ID: String = ""
    @objc var imgAnswerUrl: String = ""
    @objc var configEffectResultList:[HFEffectResult]?
    @objc var configVoiceResultList:[HFEffectResult]?
    @objc var imgAnswerUrlList:[String]?
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// KVC
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("key:\(key)")
    }
    
    override func setNilValueForKey(_ key: String) {
        
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        type    <- ((map["type"]),IntTransform())
        waitTime    <- (map["waitTime"],IntTransform())
        imgAnswerTrueIndex    <- (map["imgAnswerTrueIndex"],IntTransform())
        startTime    <- (map["startTime"],IntTransform())
        ID    <- map["id"]
        imgAnswerUrl    <- map["imgAnswerUrl"]
        configEffectResultList    <- map["configEffectResultList"]
        configVoiceResultList    <- map["configVoiceResultList"]
        imgAnswerUrlList    <- map["imgAnswerUrlList"]
        
    }
}
