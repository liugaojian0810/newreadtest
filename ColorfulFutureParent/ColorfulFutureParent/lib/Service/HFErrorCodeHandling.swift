//
//  HFErrorCodeHandling.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFErrorCodeHandling: NSObject {

    static func errorMessage(_ errorCode: String) -> String {
        
        let errorModel: [String:String] = [
            ////输入参数错误
            "1610001":"参数错误",
            "1610002":"删除成功",
            "1610003":"删除失败",
            "1610004":"启用成功",
            "1610005":"启用失败",
            "1610006":"上传失败",
            
            /**
             * 账户问题
             * 号段：1610**
             */
            "161000":"当前用户未登录",
            "161001":"该用户存在",
            "161002":"账号被冻结",
            "161003":"原密码不正确",
            "161004":"两次输入密码不一致",
            "161005": "当前手机号已注册可直接登录",
            "161006": "账号激活失败",
            "161007": "操作失败",
            
            /**
             * 登录相关
             */
            "161050": "登录类型异常",
            "161051": "手机号不可为空",
            "161052": "手机号格式不正确",
            "161053": "账号信息异常",
            "161054": "验证码格式不正确",
            "161055": "登录名不可为空",
            "161056": "登录密码不可为空",
            "161057": "微信OPENID不可为空",
            "161058": "需绑定手机号",
            "161059": "需修改密码",
            "161060": "微信已绑定",
            "161061": "用户信息异常",
            "161062": "两次输入密码不一致",
            "161063": "手机号已绑定",
            "161064": "账号或密码错误",
            "700":"登录过期，请重新登录",
            /**
             * 信息问题
             * 号段：1611**
             */
            "161100":"当前用户未登录",
            "161101":"该用户存在",
            "161102":"账号被冻结",
            "161103":"原密码不正确",
            "161104":"两次输入密码不一致",
            "161105":"完善信息失败请联系管理员",
            "161106":"当前用户信息已存在",
            "161107":"园长信息不存在",
            "161108":"用户只能修改自己的信息",
            "161109":"该用户的手机号已存在",
            "161110":"该园长用户不存在",
            "161111":"该园长用户已经激活过了",
            "161112":"幼儿园已经绑定过执行园长了",
            "161113":"用户已经是其他幼儿园的执行园长了",
            "161114":"用户设备不存在",
            "161115":"用户已绑定其他幼儿园",
            "161116":"该微信号已经绑定了其它账号",
            "161117":"当前用户已经绑定了微信",
            "161118":"当前用户尚未绑定微信",
            "161119":"该手机号尚未注册用户",
            "161120":"请求签名不能为空",
            "161121":"请求签名长度不正确",
            "161122":"请求签名值错误",
            "161123":"请求签名已存在",
            "161124":"请求签名时间戳错误",
            "161125":"您已修改过用户名不可再次修改",
            "161126":"用户名重复，请重新编辑",
            "161127":"用户名与当前用户名相同，请重新编辑",
            "161128":"数据不可为空",
            "161129":"幼儿园名称不可为空",
            "161130":"省不可为空",
            "161131":"省code不可为空",
            "161132":"市不可为空",
            "161133":"市code不可为空",
            "161134":"区不可为空",
            "161135":"区code不可为空",
            "161136":"详细地址不可为空",
            "161137":"暂无数据",
            "161138":"您的用户名不符合规则",

            /**
             * 组织架构
             * 号段：1619**
             */
            "161900":"此岗位下已有员工,不可许删除",
            "161901":"岗位类型不可为空",

            /**
             * 学期问题
             * 号段：16320*
             */
            "163200":"您已经设置过当前学期，请不要重复设置",
            "163201":"幼儿园已使用该学期，无法编辑",
            "163202":"学期时间已过，无法编辑",
            "163203":"本学期内的结束日期不能小于开始日期",

            /**
             * 年级问题
             * 号段：16321*
             */
            "163210":"您已经设置过当前年级，请不要重复设置",

            /**
             * 班级问题
             * 号段：16322*
             */
            "163220":"当前班级已有宝宝、不允许修改年级",
        ]
        return errorModel[errorCode] ?? ""
    }
    
}
