//
//  HFDate.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/9/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

/// 服务器时间数据模型
private class ServerTimeModel : Mappable {

    var date: String = ""
    var time: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        date    <- map["date"]
        time    <- map["time"]
    }
    
}

/// 服务器与本地时间差值存储的key
let ServerTimeIntervalKey = "ServerTimeIntervalKey"

extension Date {
    
    static func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    static func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string) ?? Date.init(timeIntervalSince1970: 0)
        return date
    }
}

extension Date {
    
    /// 同步系统时间
    static func syncSystemTime(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        
        let parameters = [String: AnyObject]()
        let beforeDate = Date() // 记录网络请求前的本地时间
        
        func saveInterval(model: ServerTimeModel?) -> Void {
            if model == nil {
                failClosure()
                return
            }
            let afterDate = Date() // 网络请求后本地时间
            let serverDate = Date.string2Date("\(model!.date) \(model!.time)") // 服务器时间
            
            // 计算差值
            let interval = serverDate.timeIntervalSince(afterDate) + (afterDate.timeIntervalSince(beforeDate)) / 2
            print("beforeDate：\(beforeDate) \nafterDate：\(afterDate)时间差值：\(interval)")
            UserDefaults.standard.setValue(interval, forKey: ServerTimeIntervalKey)
            
            successClosure()
        }
        
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.GetSystemTimeAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<ServerTimeModel>>().map(JSON: dic as! [String : Any])
            
            saveInterval(model: responseBaseModel?.model)
            
        }) { (error) in
            failClosure()
        }
    }
    
    // 获取本地时间与服务器时间的差值
    static func getServerTimeInterval() -> TimeInterval {
        return UserDefaults.standard.double(forKey: ServerTimeIntervalKey)
    }
}

extension  Date{
    ///  获取服务器时间
    static func serverDate() -> Date{
        let currentDate = Date()
        return currentDate.addingTimeInterval(self.getServerTimeInterval())
    }
}

extension Date {
    
    /// 判断当前日期是否为今年
    func isThisYear() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let yearComps = calender.component(.year, from: self)
        // 获取现在的年份
        let nowComps = calender.component(.year, from: Date())
        return yearComps == nowComps
    }
    
    /// 是否是昨天
    func isYesterday() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        // 根据头条显示时间 ，我觉得可能有问题 如果comps.day == 0 显示相同，如果是 comps.day == 1 显示时间不同
        // 但是 comps.day == 1 才是昨天 comps.day == 2 是前天
        //        return comps.year == 0 && comps.month == 0 && comps.day == 1
        return comps.year == 0 && comps.month == 0 && comps.day == 0
    }
    
    /// 是否是前天
    func isBeforeYesterday() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        //
        //        return comps.year == 0 && comps.month == 0 && comps.day == 2
        return comps.year == 0 && comps.month == 0 && comps.day == 1
    }
    
    /// 判断是否是今天
    func isToday() -> Bool {
        // 日期格式化
        let formatter = DateFormatter()
        // 设置日期格式
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: self)
        let nowStr = formatter.string(from: Date.serverDate())
        return dateStr == nowStr
    }
    
}
