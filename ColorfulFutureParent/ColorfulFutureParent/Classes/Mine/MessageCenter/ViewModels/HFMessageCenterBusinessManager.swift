//
//  HFMessageCenterBusinessManager.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2021/2/4.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit


enum JumpIdentifier: String {
    
    //园长端
    /**
     订单待支付状态    支付页面    event_kg_order_to_be_paid
     成长营，幼儿园云家园还有15个自然日到期    云家园购买页    event_kg_cloud_home_become_due
     成长营，慧凡教育活动安排表发布    教育活动安排表页面    event_kg_release_the_timetable
     代理收入    钱包收入明细    event_kg_agency_income    {"wtdId":"4"}
     互动营分利    钱包收入明细    event_kg_interactive_profit_sharing    {"wtdId":"4"}
     余额提现失败    提现失败详情    event_kg_withdrawal_of_balance_failed    {"wtdId":"4"}
     审批通过    审批详情    event_kg_approved    {"apId":""}
     审批拒绝    审批详情    event_kg_approval_rejected    {"apId":""}
     审批状态更新    审批详情    event_kg_approval_status_update
     新审批    审批详情    event_kg_new_approval
     待办事宜超时    审批详情    event_kg_to_do_timeout
     宝宝家长填写完成入园申请表    xxx入园申请表    event_kg_baby_finish_application_from    {"ciId":"CI202101290513591357"}
     教职工填写完成入职申请表    xxx入职申请表    event_kg_teacher_finish_application_from
     宝宝家长加入幼儿园    xxx入园申请表    event_kg_parent_join_kindergarten    {"ciId":"CI202101290513591357"}
     教职工加入幼儿园    xxx入职申请表    event_kg_teacher_join_kindergarten    {"ki":""}
     */
    case event_kg_order_to_be_paid = "event_kg_order_to_be_paid"
    case event_kg_cloud_home_become_due = "event_kg_cloud_home_become_due"
    case event_kg_release_the_timetable = "event_kg_release_the_timetable"
    case event_kg_agency_income = "event_kg_agency_income"
    case event_kg_interactive_profit_sharing = "event_kg_interactive_profit_sharing"
    case event_kg_withdrawal_of_balance_failed = "event_kg_withdrawal_of_balance_failed"
    case event_kg_approved = "event_kg_approved"
    case event_kg_approval_rejected = "event_kg_approval_rejected"
    case event_kg_approval_status_update = "event_kg_approval_status_update"
    case event_kg_new_approval = "event_kg_new_approval"
    case event_kg_to_do_timeout = "event_kg_to_do_timeout"
    case event_kg_baby_finish_application_from = "event_kg_baby_finish_application_from"
    case event_kg_teacher_finish_application_from = "event_kg_teacher_finish_application_from"
    case event_kg_parent_join_kindergarten = "event_kg_parent_join_kindergarten"
    case event_kg_teacher_join_kindergarten = "event_kg_teacher_join_kindergarten"
    
    //家长端
    /**
     订单待支付状态    支付页面    event_prt_order_to_be_paid
     成长营，教师点击发送报告和小任务按钮的当天下午5点    成长营页面    event_prt_growth_get_teacher_report
     互动营，家长成功预约互动营    无    event_prt_interact_appointment_success
     互动营，互动活动正常结束后，慧凡按预约人数均摊将多余宝石退给用户    我的互动-已取消列表    event_prt_interact_return_gem
     互动营，互动活动被家长主动取消    我的互动-已取消列表    event_prt_interact_cancel_appointment
     互动营，互动活动结束前教师没有点击上课按钮，活动结束后系统退回宝石    我的互动-已取消列表    event_prt_interact_return_gem
     互动营，互动活动预约人数不足，课程开始时，系统取消互动活动，退回宝石    我的互动-已取消列表    event_prt_interact_return_gem
     互动营，互动活动开始前15分钟提醒    我的互动-预约列表    event_prt_interact_start_reminding
     互动营，教师成功提交互动活动报告    互动报告列表    event_prt_interact_get_teacher_report
     */
    case event_prt_order_to_be_paid = "event_prt_order_to_be_paid"
    case event_prt_growth_get_teacher_report = "event_prt_growth_get_teacher_report"
    case event_prt_interact_appointment_success = "event_prt_interact_appointment_success"
    /**
     我的互动-已取消列表
     我的互动-已取消列表
     我的互动-已取消列表
     */
    case event_prt_interact_return_gem = "event_prt_interact_return_gem"
    case event_prt_interact_cancel_appointment = "event_prt_interact_cancel_appointment"
    case event_prt_interact_start_reminding = "event_prt_interact_start_reminding"
    case event_prt_interact_get_teacher_report = "event_prt_interact_get_teacher_report"
    
    
    //教师端
    /**
     订单待支付状态    支付页面    event_teh_order_to_be_paid
     成长营，慧凡教育活动安排表发布    教育活动安排表页面    event_teh_release_the_timetable
     成长营，慧凡开发在数据库里对教育活动安排表更新    教育活动安排表发布    event_teh_update_the_timetable
     成长营，还有半小时开始当天的第一节教育活动    教育活动提醒    event_teh_course_start_in_half_an_hour
     成长营，教师所在班被分配了使用云家园成长营的班额    云家园账号分配通知    event_teh_class_distribution_quota
     成长营，教师所在班被取消了使用云家园成长营的班额    云家园账号被取消通知    event_teh_class_cancel_quota
     互动营，距离互动活动开始时间还有15分钟且预约人数不足时    互动营开始活动列表    event_teh_interact_not_enough_people
     互动营，活动前15分钟提醒    互动营开始活动列表    event_teh_interact_start_reminding
     审批通过    审批详情    event_teh_approved
     审批拒绝    审批详情    event_teh_approval_rejected
     审批状态更新    审批详情    event_teh_approval_status_update
     代理收入    钱包收入明细    event_teh_agency_income    {"wtdId":"4"}
     互动营分利    钱包收入明细    event_teh_interactive_profit_sharing    {"wtdId":"4"}
     余额提现失败    提现失败详情    event_teh_withdrawal_of_balance_failed    {"wtdId":"4"}
     */
    case event_teh_order_to_be_paid = "event_teh_order_to_be_paid"
    case event_teh_release_the_timetable = "event_teh_release_the_timetable"
    case event_teh_update_the_timetable = "event_teh_update_the_timetable"
    case event_teh_course_start_in_half_an_hour = "event_teh_course_start_in_half_an_hour"
    case event_teh_class_distribution_quota = "event_teh_class_distribution_quota"
    case event_teh_class_cancel_quota = "event_teh_class_cancel_quota"
    case event_teh_interact_not_enough_people = "event_teh_interact_not_enough_people"
    case event_teh_interact_start_reminding = "event_teh_interact_start_reminding"
    case event_teh_approved = "event_teh_approved"
    case event_teh_approval_rejected = "event_teh_approval_rejected"
    case event_teh_approval_status_update = "event_teh_approval_status_update"
    case event_teh_agency_income = "event_teh_agency_income"
    case event_teh_interactive_profit_sharing = "event_teh_interactive_profit_sharing"
    case event_teh_withdrawal_of_balance_failed = "event_teh_withdrawal_of_balance_failed"
}


class HFMessageCenterBusinessManager {
    
    //单例创建
    static let shared = HFMessageCenterBusinessManager()
    
    init() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 通知消息页面跳转
    /// - Parameters:
    ///   - iden: 跳转页面业务标识
    ///   - msgModel: 消息模型
    func msgJump(_ iden: JumpIdentifier, _ msgModel: HFMessageListModel, _ fromVc: HFNewBaseViewController) {
        
        if HFClientInfo.currentClientType == .ClientTypeKindergarten {
            switch iden.rawValue {
            case "event_kg_order_to_be_paid"://订单待支付状态    支付页面
                print(iden.rawValue)
            case "event_kg_cloud_home_become_due"://成长营，幼儿园云家园还有15个自然日到期    云家园购买页
                print(iden.rawValue)
            case "event_kg_release_the_timetable"://成长营，慧凡教育活动安排表发布    教育活动安排表页面
                print(iden.rawValue)
                
            case "event_kg_agency_income"://代理收入    钱包收入明细
                print(iden.rawValue)
                
            case "event_kg_interactive_profit_sharing"://互动营分利    钱包收入明细
                print(iden.rawValue)
                
            case "event_kg_withdrawal_of_balance_failed"://余额提现失败    提现失败详情
                print(iden.rawValue)
                
            case "event_kg_approved"://审批通过    审批详情
                print(iden.rawValue)
                
            case "event_kg_approval_rejected"://审批拒绝    审批详情
                print(iden.rawValue)
                
            case "event_kg_approval_status_update"://审批状态更新    审批详情
                print(iden.rawValue)
                
            case "event_kg_new_approval"://新审批    审批详情
                print(iden.rawValue)
                
            case "event_kg_to_do_timeout"://待办事宜超时    审批详情
                print(iden.rawValue)
                
            case "event_kg_baby_finish_application_from"://宝宝家长填写完成入园申请表    xxx入园申请表
                print(iden.rawValue)
                
            case "event_kg_teacher_finish_application_from"://教职工填写完成入职申请表    xxx入职申请表
                print(iden.rawValue)
                
            case "event_kg_parent_join_kindergarten"://宝宝家长加入幼儿园    xxx入园申请表
                print(iden.rawValue)
                
            case "event_kg_teacher_join_kindergarten"://教职工加入幼儿园    xxx入职申请表
                print(iden.rawValue)
            default:
                print(iden.rawValue)
            }
        }else if HFClientInfo.currentClientType == .ClientTypeKindergarten {
            switch iden.rawValue {
            case "event_prt_order_to_be_paid"://订单待支付状态    支付页面
                print(iden.rawValue)
                
            case "event_prt_growth_get_teacher_report"://成长营，教师点击发送报告和小任务按钮的当天下午5点    成长营页面
                print(iden.rawValue)
                
            case "event_prt_interact_appointment_success"://互动营，家长成功预约互动营    无
                print(iden.rawValue)
                
            case "event_prt_interact_return_gem":
                //互动营，互动活动正常结束后，慧凡按预约人数均摊将多余宝石退给用户    我的互动-已取消列表
                //互动营，互动活动结束前教师没有点击上课按钮，活动结束后系统退回宝石    我的互动-已取消列表
                //互动营，互动活动预约人数不足，课程开始时，系统取消互动活动，退回宝石    我的互动-已取消列表
                print(iden.rawValue)
                
            case "event_prt_interact_cancel_appointment"://互动营，互动活动被家长主动取消    我的互动-已取消列表
                print(iden.rawValue)
                
            case "event_prt_interact_start_reminding"://互动营，互动活动开始前15分钟提醒    我的互动-预约列表
                print(iden.rawValue)
                
            case "event_prt_interact_get_teacher_report"://互动营，教师成功提交互动活动报告    互动报告列表
                print(iden.rawValue)
                
            default:
                print(iden.rawValue)
            }
        }else{
            switch iden.rawValue {
            
            case "event_teh_order_to_be_paid"://订单待支付状态    支付页面
                print(iden.rawValue)
                
            case "event_teh_release_the_timetable"://成长营，慧凡教育活动安排表发布    教育活动安排表页面
                print(iden.rawValue)
                
            case "event_teh_update_the_timetable"://成长营，慧凡开发在数据库里对教育活动安排表更新    教育活动安排表发布
                print(iden.rawValue)
            case "event_teh_course_start_in_half_an_hour"://成长营，还有半小时开始当天的第一节教育活动    教育活动提醒
                print(iden.rawValue)
                
            case "event_teh_class_distribution_quota"://成长营，教师所在班被分配了使用云家园成长营的班额    云家园账号分配通知
                print(iden.rawValue)
                
            case "event_teh_class_cancel_quota"://成长营，教师所在班被取消了使用云家园成长营的班额    云家园账号被取消通知
                print(iden.rawValue)
            case "event_teh_interact_not_enough_people"://互动营，距离互动活动开始时间还有15分钟且预约人数不足时    互动营开始活动列表
                print(iden.rawValue)
            case "event_teh_interact_start_reminding"://互动营，活动前15分钟提醒    互动营开始活动列表
                print(iden.rawValue)
            case "event_teh_approved"://审批通过    审批详情
                print(iden.rawValue)
            case "event_teh_approval_rejected"://审批拒绝    审批详情
                print(iden.rawValue)
            case "event_teh_approval_status_update"://审批状态更新    审批详情
                print(iden.rawValue)
            case "event_teh_agency_income"://代理收入    钱包收入明细
                print(iden.rawValue)
            case "event_teh_interactive_profit_sharing"://互动营分利    钱包收入明细
                print(iden.rawValue)
            case "event_teh_withdrawal_of_balance_failed"://余额提现失败    提现失败详情
                print(iden.rawValue)
            default:
                print(iden.rawValue)
            }
        }
    }
}
