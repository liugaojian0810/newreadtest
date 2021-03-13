//
//  HFString.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/18.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import CommonCrypto
/**
 安全级别
 */
enum SecuriLevel: Int {
    case low = 0
    case mid = 1
    case high = 2
}

/**
 字符串截取
 */
extension String{
    
    /// 从某个位置开始截取：
    /// - Parameter index: 起始位置
    public func substring(from index: Int) -> String {
        if(self.count > index){
            let startIndex = self.index(self.startIndex,offsetBy: index)
            let subString = self[startIndex..<self.endIndex];
            return String(subString);
        }else{
            return ""
        }
    }
    
    /// 从零开始截取到某个位置：
    /// - Parameter index: 达到某个位置
    public func substring(to index: Int) -> String {
        if(self.count > index){
            let endindex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<endindex]
            return String(subString)
        }else{
            return self
        }
    }
    
    /// 某个范围内截取
    /// - Parameter rangs: 范围
    public func subString(rang rangs:NSRange) -> String{
        var string = String()
        if(rangs.location >= 0) && (self.count > (rangs.location + rangs.length)){
            let startIndex = self.index(self.startIndex,offsetBy: rangs.location)
            let endIndex = self.index(self.startIndex,offsetBy: (rangs.location + rangs.length))
            let subString = self[startIndex..<endIndex]
            string = String(subString)
        }
        return string
    }
    
    
    /// 截取某个位置的某个字符
    /// - Parameter index: 下表索引
    /// - Returns: 字符
    public func subChar(at index: Int) -> String{
        assert(index < self.count, "字符串索引越界了！")
        let positionIndex = self.index(self.startIndex, offsetBy: index)
        let char = self[positionIndex]
        return String(char)
    }
    
    
    /// 获取首个字符
    /// - Returns: 单个字符的字符串
    func subFirstChar() -> String {
        return subChar(at: 0)
    }
    
    
}


/**
 字符串高度、宽度计算
 */
extension String {
    
    func get_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    
    func get_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    
    func get_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    func get_heightForComment(string: NSAttributedString, width: CGFloat) -> CGFloat {
        if string.isKind(of: NSNull.classForCoder()) {
            return 0
        }
        let rect = string.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
        return ceil(rect.height)
    }
}


/**
 字符串验证
 */
extension String {
    /// 是不是标准手机号
    func isPhoneNum() -> Bool {
        do {
            let pattern = "^1[0-9]{10}$"
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
            return matches.count > 0
        }
        catch {
            return false
        }
        
    }
    /// 是不是标准邮箱
    func isEmail() -> Bool {
        do {
            let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    
    /// 用户名校验（字母+数字组合，同时存在 8-20位）
    func isUsrName() -> Bool {
        do {
            let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$"
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    
    /// 密码安全级别判断
    func securityLever() -> SecuriLevel {
        
        //  大小写字母匹配，数字匹配，非字母数字匹配
        let patterns = ["[a-zA-Z]","[0-9]","[^A-Za-z0-9]"]
        
        var intResult = 0
        for pattern in patterns {
            do {
                let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
                let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
                if matches.count > 0 {
                    intResult += 1
                }
            }
            catch {
            }
        }
        if intResult < 2 {
            return .low
        }
        if intResult == 2{
            return .mid
        }
        return .high
    }
    
    private func judgeRange(_ arr: [String], _ password: NSString) -> Bool {
        var range: NSRange = NSRange()
        var result: Bool = false
        for item in arr[0..<arr.count] {
            range = password.range(of: item)
            if(range.location != NSNotFound)
            {
                result = true;
            }
        }
        return result
    }
    
}


extension String {
    
    /// 判断字符串是否为空
    /// - Returns: 返回是或者不是
    func isEmptyStr() -> Bool {
        
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
        
    }
}

extension String {
    
    /// 判断字符串长度
    /// - Returns: 字符串长度
    func length() -> Int {
        return self.count
    }
}

extension String {
    /// 省市格式化
    static func addressFormat(province: String, city: String) -> String {
        return "\(province.isEmpty ? "" : province + "-")\(city.isEmpty ? "" : city)"
    }
    /// 省市县格式化
    static func addressFormat(province: String, city: String, county: String) -> String {
        return "\(province.isEmpty ? "" : province + "-")\(city.isEmpty ? "" : city + "-")\(county.isEmpty ? "" : county)"
    }
}

extension String {
    
    /// 根据出生日期计算年龄的方法(Y)
    static func caculateAgeY(birthday: String) -> (String){
        // 格式化日期
        let d_formatter = DateFormatter()
        d_formatter.dateFormat = "yyyy-MM-dd"
        let birthDay_date = d_formatter.date(from: birthday)
        // 出生日期转换 年月日
        if let tempBirthDay_date = birthDay_date {
            // 获得出生的年月日
            let ageComponents = NSCalendar.current.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: tempBirthDay_date, to: NSDate() as Date)
            let year  = ageComponents.year!
            let month = ageComponents.month!
            var iAge = year
            if 0 < month {
                iAge += 1
            }
            return "\(iAge)"
        }
        // 计算错误
        return "0"
    }
    
    /// 根据出生日期计算年龄的方法(YMD)
    static func caculateAgeYMD(birthday: String) -> (String){
        // 格式化日期
        let d_formatter = DateFormatter()
        d_formatter.dateFormat = "yyyy-MM-dd"
        let birthDay_date = d_formatter.date(from: birthday)
        // 出生日期转换 年月日
        if let tempBirthDay_date = birthDay_date {
            // 获得出生的年月日
            let ageComponents = NSCalendar.current.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: tempBirthDay_date, to: NSDate() as Date)
            let year  = ageComponents.year!
            let month = ageComponents.month!
            let day   = ageComponents.day!
            var desc = ""
            if 0 < year {
                desc += "\(year)岁"
            }
            if 0 < month {
                desc += "\(month)月"
            }
            if 0 < day {
                desc += "\(day)天"
            }
            return desc
        }
        // 计算错误
        return "0岁"
    }
    
    /// 时间格式转化  20202020 转化成2020-20-20
    /// - Parameter ymd: 年-月-日
    /// - Returns: 转化好的年月日
    func timeStrTranslate() -> String {
        if self.length() >= 8 {
            var temp = self
            let firstIndex = temp.index(temp.startIndex, offsetBy: 4)
            temp.insert("-", at: firstIndex)
            let endIndex = temp.index(temp.startIndex, offsetBy: 7)
            temp.insert("-", at: endIndex)
            return temp
        }else{
            return self
        }
    }
}

extension String {
    /// MD5加密类型
    enum MD5EncryptType {
        /// 32位小写
        case lowercase32
        /// 32位大写
        case uppercase32
        /// 16位小写
        case lowercase16
        /// 16位大写
        case uppercase16
    }
    
    func DDMD5Encrypt(_ md5Type: MD5EncryptType = .lowercase32) -> String {
        guard self.count > 0 else {
            print("⚠️⚠️⚠️md5加密无效的字符串⚠️⚠️⚠️")
            return ""
        }
        
        let cCharArray = self.cString(using: .utf8)
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
        switch md5Type {
        case .lowercase32:
            return uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
        case .uppercase32:
            return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
        case .lowercase16:
            let _ = uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
            return ""
        case .uppercase16:
            return ""
        }
    }
}

extension String {
    
    /// 安全
    func securityPhone(_ phone: String) -> String {
        if !phone.isPhoneNum() {
            return phone
        }
        let newPhone = String(format: "%@", phone)
        let midStr = newPhone.subString(rang: NSRange.init(location: 3, length: 4))
        return newPhone.replacingOccurrences(of: midStr, with: "****")
    }
    
    /// 安全
    static func securityPhone(_ phone: String) -> String {
        if !phone.isPhoneNum() {
            return phone
        }
        let newPhone = String(format: "%@", phone)
        let midStr = newPhone.subString(rang: NSRange.init(location: 3, length: 4))
        return newPhone.replacingOccurrences(of: midStr, with: "****")
    }
    
    /// 安全
    func securityPhoneFist(_ phone: String) -> String {
        if !phone.isPhoneNum() {
            return phone
        }
        let newPhone = String(format: "%@", phone)
        let midStr = newPhone.subString(rang: NSRange.init(location: 0, length: 7))
        return newPhone.replacingOccurrences(of: midStr, with: "*******")
    }
    
    /// 安全
    static func securityPhoneFist(_ phone: String) -> String {
        if !phone.isPhoneNum() {
            return phone
        }
        let newPhone = String(format: "%@", phone)
        let midStr = newPhone.subString(rang: NSRange.init(location: 0, length: 7))
        return newPhone.replacingOccurrences(of: midStr, with: "*******")
    }
    
}

extension String {
    /// 从String中截取出参数
    var urlParameters: [String: AnyObject]? {
        // 判断是否有参数
        guard self.range(of: "?") != nil else {
            return nil
        }
        
        var params = [String: AnyObject]()
        // 截取参数
        let startIndex = (self as NSString).range(of: "?").location + 1
        let paramsString = substring(from: startIndex)
        
        // 判断参数是单个参数还是多个参数
        if paramsString.contains("&") {
            
            // 多个参数，分割参数
            let urlComponents = paramsString.components(separatedBy: "&")
            
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.components(separatedBy:"=")
                let key = pairComponents.first
                let value = pairComponents.last
                if let key = key, let value = value {
                    params[key] = value as AnyObject
                }
            }
            
        } else {
            
            // 单个参数
            let pairComponents = paramsString.components(separatedBy: "=")
            
            // 判断是否有值
            if pairComponents.count == 1 {
                return nil
            }
            
            let key = pairComponents.first
            let value = pairComponents.last
            if let key = key, let value = value {
                params[key] = value as AnyObject
            }
        }
        
        return params
    }

}

extension String {
    
    /// 将数字转换为带圆圈数字
    static func numberString(index: Int) -> String {
        let numbers = "①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳㉑㉒㉓㉔㉕㉖㉗㉘㉙㉚㉛㉜㉝㉞㉟㊱㊲㊳㊴㊵㊶㊷㊸㊹㊺㊻㊼㊽㊾㊿"
        return numbers.subString(rang: NSRange.init(location: index, length: 1))
    }
}
