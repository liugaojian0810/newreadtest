//
//  HFServiceAPI.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation


// MARK: **********************************会员权益**********************************
public let S_HOST_MEM = "/api-mem"

struct HFMemAPI {
    
    // MARK: 会员专区
    /// 用户会员信息接口
    let MemberDetailAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memusr/user/mem/detail"
    
    /// 《会员专区会员卡信息》-查询会员卡信息权益
    public static let GetCardInfoAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcard/getCardInfo"
    
    /// 代理产品- 用户代理产品列表
    public let AgentprodbyusrlistAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memagentgoods/agentgoodtotalbyusrlist"
    
    /// 幼儿园会员信息接口
    public let KindergartenMemberDetailAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memkindergarten/ki/mem/detail"
    
    /// 判断当前用户是否会员状态
    public let UserIsMemAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memusr/user/ismem"
    
    /// 判断当前幼儿园是否会员状态
    public let MemkindergartenIsMemAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memkindergarten/ki/ismem"
    
    /// 个人高端班列表
    public static let MemusrrightsAdvancedClassAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memuserrights/advanced/class"
    
    /// 用户权益使用情况接口
    public static let MemusrrightsRightsUseCaseAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memuserrights/rights/use/case"
    
    /// 幼儿园权益使用情况接口
    public static let MemusrrightsRightsUseAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memkirights/rights/use"
    
    /// 代理产品收入明细列表
    public static let MemusrrightsAgentIncomeAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memagentprofit/agent/income"
    
    /// 代理产品-下拉筛选
    public static let AppagentgoodspulllistAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memagentgoods/appagentgoodspulllist"
    
    
    // MARK: 卡包
    
    ///个人获取卡包列表
    static let CardpackageAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcardpackage/parent/get_mem_card_package"
    
    /// 使用卡
    static let UseCardpackageAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memusr/parent/use/card_automatic"

    
    ///判断是否存在未使用卡包1（不包含权益赠送）
    static let UnusedCardpackageAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcardpackage/unused_card_package"
    
    ///会员卡赠送接口(赠送给园长)
    static let AddgivingAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcardpackage/giving"
    
    ///会员卡绑定幼儿园接口
    static let BindingAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memkindergarten/use/card"
    
    ///个人使用激活接口
    static let ActivateuseAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memusr/use/card"
    
    ///查询会员卡组合详情
    static let SelectGroupDetailAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcardpackage"
    
    ///查询会员卡信息
    static let SelectCardMsgAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcardpackage/card/detail"

    ///新增
    static let CardAddAPI = "\(S_HOST_MEM)/v\(S_VERSION)/memcardpackage"
}


// MARK: **********************************基础架构**********************************
public let S_HOST_BASE_USE = "/api-user"

struct HFBaseUseAPI {
    
    // MARK: 个人
    /// 查询教师用户信息
    public static let UserPersonalInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/user/employee_info_details"
    
    /// 查询当前教师所在幼儿园信息
    public static let KingdInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/employee_kg_info"
    /// 班级宝宝列表
    public static let ClassChildlistAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/class_grouping"
    
     /// 修改园长头像
     public static let UserUpdatePicAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/director_app/upd_head_img"
     
     /// 修改园长备注名
     public static let UserUpdateMarkAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/director_app/upd_remark_name"
     
     /// 修改用户性别
     public static let UserUpdateSexAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_info/upd_user_sex"
    
     /// 用户修改用户名
     public static let UserUpdateUserNameAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_info/upd_user_name"
 
     /// 个人中心 - 编辑个人信息
     public static let UpdateUserMsgAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent_user/personal_detail"


    // MARK: 我的幼儿园
    /// 幼儿园列表接口
    public let MyKindergartenListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/kg/my_page"
    
    /// 园长登录选择园所
    public let ChooseGardenLogAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/chooseGarden"
    
    /// 保存/提交/编辑 幼儿园
    public static let SubmitKindergartenAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/kg"
    
    /// 查询执行园长接口
    public let GetExecuteDirectorAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/kg/get_exe_dir"
    
    /// 绑定执行园长
    public let BindExeDirAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/kg/bind_exe_dir"
    
    /// 解绑执行园长
    public let UnBindExeDirAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/kg/un_bind_exe_dir"
    
    // MARK: 宝宝管理
    /// 班级宝宝列表
    public let ClassChildlistAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/class_childlist"
    
    
    // MARK: 宝宝管理
    /// 添加宝宝
    public static let AddChildAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child"
    
    /// 家长端添加宝宝
    public static let AddInfoChildAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/info_add"
    
    /// 宝宝切换列表
    public static let GetCutChildListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/cut_child_list"
    
    /// 家长加入幼儿园
    public static let ParentJoinKgAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent/joinkg"
    
    /// 家长弹窗
    public static let ParentPopwindows = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent/popwindows"
    
    /// 宝宝入园申请弹窗
    public static let ParentPopchildapplyAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent/popchildapply"
    
    /// 查看宝宝
    public static let LookChildAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/get"
    
    /// 宝宝邀请记录列表
    public static let ChildInvitationLogsAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/invitation_logs"
    
    /// 再次邀请
    public static let AgainInviteChildAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/again_invite"
    
    /// 搜索宝宝
    public static let SearchChildListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/search_childs"
    
    /// 宝宝列表
    public static let UnClassBabyListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/class_grouping"
    
    /// 编辑宝宝信息
    public static let EditChildInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/update"
    
    /// 入园申请保存/提交
    public static let ChildEntryKiAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/info_upd"
    
    /// 宝宝数据确认同步
    public static let ChildInfoSynchronizationAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/info_Synchronization"
    
    /// 查看宝宝信息（未绑定）
    public static let ChildPrtlInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/child/child_prtl_info"
    
    
    //MARK: 教师管理
    /// 教职工详情
    public static let TeacherDetailAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/info/employee_user_details"
    
    /// 查询当前教师入职状态
    public static let TeacherJoinStateAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/user/employee_join_state"
    
    /// 家长/教师 同意拒绝操作
    public static let RejectInvitionAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent/rejectinvition"
    
    
    // MARK: 设置
    /// 消息通知开关
    public static let NoticeSwitchAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_client/notify_switch"
    
    /// 修改绑定的推送设备号
    public static let DeviceNoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_client/device_no"

    /// 园长退出登录
    public static let LogoutAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/logout"

    /// 问题反馈
    public static let FeedbackAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/problems/feedback"

    /// 园长端获取APP版本信息
    public static let AppVersionAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/version_control/app/version"
    
    
    // MARK: 账号与安全
    /// 获取账号安全信息
    public static let AccountSecuInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/account_security"
    
    /// 用户绑定微信
    public static let AccountBindWeChatAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_client/weixin_bind"
    
    /// 校验微信是否绑定过其它账号
    public static let AccountCheckBindWeChatAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_client/check_bind_user"

    /// 解除微信绑定
    public static let AccountWeixinUnBindWeChatAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_client/weixin_unbind"

    /// 原密码校验
    public static let AccountOldPasswordVerifyAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/check_old_password"
    
    /// 用户修改密码
    public static let AccountUpdatePasswordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/user_password"
    
    /// 校验手机号
    public static let AccountOldPhoneVerifyAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/phone_check"
    
    /// 用户修改手机号
    public static let AccountUpdatePhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/user_phone"
    
    /// 登录设备记录列表
    public static let LoginLogListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/device/page"

    /// 删除登录设备记录
    public static let DeleteLoginLogAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/device"

    /// 撤销注销申请
    public static let AccountCancelLogoffAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/cancel_logoff"
    
    /// 新用户注册
    public static let AccountRegistAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/register"
    
    /// 发送业务验证码
    public static let AccountSendBizVcodeAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/sms/send_biz_vcode"
    
    /// 校验业务验证码
    public static let VerifyBizVcodeAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/sms/verify_biz_vcode"
    
    /// 其它设备登录短信验证
    public static let LoginLogMsgVerifyAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/login_device_verify"

    /// 获取公司客服电话
    public static let CompanyPhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/companys/customer_phone"

    /// 校验园长是否有幼儿园接口
    public static let HaveKingdergationAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/kindergarten_count"
    
    /// 账号钱包余额查询
    public static let WalletBalanceAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/wallet_info"

    /// 校验手机号和验证码是否匹配
    public static let VerifyQrCodeAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/sms/phone_vcode_verify"
    
    /// 园长撤销注销申请
    public static let UndoCancelApplayAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/cancel_logoff"
    
    /// 获取用户协议接口
    public static let GetUserAgrementAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/agreement"
    
    /// 园长注销提现接口
    public static let CancelWalletAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/logoff_withdraw"

    
    // MARK: 人脸认证
    /// 用户人脸认证
    public static let FaceAuthAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/face_verify_cancel"

    
    
    
    // MARK: 登录

    /// 账号验证码校验
    public static let AccountPhoneVcodeCheckAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/phone_vcode_check"
    
    /// 设置初始密码
    public static let AccountInitPasswordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/set_password_for_register"
    
    /// 通过验证码修改密码
    public static let AccountForgetSmsPasswordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/sms_password"
    
    /// 微信登录绑定手机号
    public static let AccountWeixinBindPhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/directors/weixin_bind_phone"
    
    /// 校验手机号是否绑定过微信
    public static let AccountCheckMobileWxBindAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/check_mobile_wx_bind"
    
    /// 完善园长个人信息
    public static let ImproveUserInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent/perfect_info"
    
    /// 获取园长详细信息
    public static let DirInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/director_app/dir_info"
    
    
    // MARK: 教职工管理
    /// 教师列表
    public static let EmployeeListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/list"
    
    /// 办理离职
    public static let EmployeeQuitAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/quit"
    
    /// 教师邀请记录
    public static let EmployeeInviteRecordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/invite_record"
    
    /// 再次邀请教师
    public static let InviteAgainAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/invite_again"
    
    /// 邀请教职工
    public static let EmployeeAddAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/entry_invitation_employee"
    
    /// 邀请页面编辑教职工使用
    public static let EditInviteEmployeesAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/editInviteEmployees"
    
    /// 加入幼儿园
    public static let JoinKindergartenEmployeesAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/info/join_kindergarten"
    
    /// 编辑教职工
    public static let EditTeacherInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/info/employee_user_edit"
    
    /// 填写教师入职申请表
    public static let EditJoinTeacherInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/info/application_join"
    
    
    // MARK: 我的
    // MARK: 宝宝管理
    
    
    // MARK: 我的钱包
    /// 开通钱包
    public static let ApplyWalletAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/apply_wallet"
    
    /// 提现银行卡列表
    public static let WithdrawalBankListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/withdrawal_bank_card_list"
    
    /// 支付银行卡列表
    public static let PayBankListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/payment_bank_card_list"

    /// 提现卡支持银行列表
    public static let SupportBankListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/personal_bind_card"
    
    /// 申请绑定银行卡
    public static let ApplyBindingBankCardAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/band_card_send_sms"
    
    /// 确认绑定银行卡
    public static let ConfirmBindingBankCardAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/add_bank_card"
    
    
    /// 校验支付密码
    public static let CheckPayPasswordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/check_pay_pwd"
    
    /// 更新钱包密码
    public static let UpdatePayPasswordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/upd_pay_password"
    
    
    /// 我的钱包页面
    public static let WalletPageAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/wallet_page"
    
    /// 我的收入页面
    public static let WalletEarnPageAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/earn_page"
    
    /// 我的个人信息
    public static let MyInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent_user/my_user_info"
    /// 提现
    public static let WalletWithdrawAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/withdraw"
    
    /// 个人中心
    public static let MyCenterInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent_user/personal_center"
    /// 提现记录列表
    public static let WalletWithdrawListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/withdraw_list"
    
    /// 个人中心 - 编辑用户信息
    public static let EditMyInfoAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent_user/personal_detail"
    /// 提现记录详情
    public static let WithdrawDetailAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/withdraw_detail"
    
    /// 个人中心 - 宝宝的家长列表
    public static let BabyParentListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent/ki_page"
    /// 提现记录删除
    public static let DelWalletWithdrawAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/wallet/withdraw_del"
    
    /// 个人中心 - 添加家长
    public static let BabyAddParentAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/parent"
    

}


// MARK: **********************************园务管理**********************************
public let S_HOST_KG_MGR = "/api-kg-mgr"

struct HFKgMgrAPI {

    
    // MARK: 年级管理
    /// 年级管理列表
    public static let GetKggradesAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kggrades/list"
    
    /// 公共年级列表
    public static let GetPublicKggradesAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kggrades/list_public"
    
    /// 班级管理列表
    public static let GetClassesListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/classes/page"
    
    /// 班级管理
    public static let GetClassesAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/classes"
    
    /// 公共班级列表
    public static let GetPublicClassesListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/classes/list_public"
    
    /// 年级编辑保存
    public static let GradeEditSaveAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kggrades"
    
    /// 年级启用/禁用
    public static let GradeEnableAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kggrades/enable"
    
    /// 学期管理列表
    public static let SemestersListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kgsemesters/list"
    
    /// 保存学期编辑
    public static let SemestersSaveAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kgsemesters"
    
    /// 主班教师列表查询
    public static let MainteacherListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/mainteachers/page"
    
    /// 招生管理列表
    public static let ChildSourcesListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_sources/page"
    
    /// 添加生源
    public static let AddChildSourcesAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_sources/"
    
    /// 生源详情
    public static let ChildSourcesDetailAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_sources"
    
    /// 新增申请
    public static let AddApplyRecordsAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/apply_records"
    
    /// 申请记录列表
    public static let GetApplyRecordsAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/apply_records/page"
    
    /// 分班
    public static let DistributeChildClassAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_class_rel/distribute"
    
    /// 调班
    public static let AdjustChildClassAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_class_rel/adjust"
    
    /// 退园
    public static let QuitChildClassAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_class_rel/quit"
    
    /// 毕业
    public static let GradChildClassAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/child_class_rel/grad"
    
    /// 根据邀请码查询幼儿园信息
    public static let GetInvitationInfoAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/invitation"
    
    /// 邀请二维码查询
    public static let InvitationQrCodeAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/invitation/qr_code"
}


// MARK: **********************************一日流程**********************************

public let S_HOST_BASE = "/api-kg-mgr"

struct HFADayProcessAPI {
    
    /// 获取一日流程列表
    public static let ADayProcessListAPI = "\(S_HOST_BASE)/v\(S_VERSION)/day_process_class_kg/list"
    
    /// 清空一日流程
    public static let ClearADayProcessAPI = "\(S_HOST_BASE)/v\(S_VERSION)/day_process_kg/clear"

    /// 一日流程恢复默认
    public static let RestoreADayProcessAPI = "\(S_HOST_BASE)/v\(S_VERSION)/day_process_kg/default"
    
    /// 修改一日流程  新建一日流程   删除一日流程
    public static let UpdateADayProcessAPI = "\(S_HOST_BASE)/v\(S_VERSION)/day_process_kg"

    /// 活动安排下拉框
    public static let CreateADayProcessAPI = "\(S_HOST_BASE)/v\(S_VERSION)/process_project/choice"
    
}

struct HFAuthorAPI {
    /// 人脸+证件验证匹配
    public static let FaceVerifyAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_authentication/face_verify"
    // 注销/修改手机号 人脸认证接口
    public static let FaceVerifyCancelAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_authentication/face_verify_cancel"
    // 检查是否实名认证
    public static let checkFaceVerifyAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_authentication/"
    // 获取注销信息
    public static let getCancelStatusAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/get_cancel_status"
}



// MARK: **********************************公共接口**********************************
struct HFPublicAPI {
    
    /// 图片上传
    public static let UploadImageAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/base_file"
    
    /// 公共字典信息接口，不包含路径最后一个值
    public static let PubDictAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/dict"
    
    
    // MARK: 公用年级列表查询
    public static let GradePublicListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/grades/list_public"
    
    // MARK: 公用学期列表查询
    public static let SemePublicListAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/semesters/list_public"
        
    /// 慧凡组织架构树
    public static let PubStructureAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/structure"
    
    /// 岗位管理列表
    public static let JobsAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/job/list_public"
    
    /// 省市县
    public static let DistrictsAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/districts"
    
    /// 民族信息查询
    public static let NationalPublicListAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/nation"
    
    /// 获取慧凡角色选择列表
    public static let RolePublicAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/role/list"

    /// 公用宝宝关系列表查询
    public static let BabyRelationshipAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/childrels/list_public"
    
    /// 查询年级-班级树
    public static let GradeClassTreeAPI = "\(S_HOST_KG_MGR)/v\(S_VERSION)/kggrades/grade_class_tree"
    
    /// 个人中心 - 编辑个人信息
    
    
}

// MARK: **********************************登录注册模块接口**********************************
struct HFLoginRegisterAPI {
    /// 用户注册 完善信息接口
    public static let UserPerfectsAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/employee/user/perfects"

    /// 注册发送验证码
    public static let SendCodeForRegisterAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/send_code_for_register"
    
    /// 用户修改手机号 接受验证码
    public static let SetNewPhoneSendMSGPhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/send_code_for_set_phone"
    
    // 用户修改手机号
    public static let SetNewPhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/update_phone"
    
    /// 快捷登录验证码
    public static let SendCodeForLoginAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/send_code_for_login"
    
    /// 园长端、教师端、家长端登录
    public static let LoginAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/app/login"
    
    /// 忘记密码 发送验证码
    public static let ForgetPasswordSendMSGAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/send_code_by_forget"
    
    /// 验证忘记密码发送验证码
    public static let ForgetPasswordCheckAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/check_code_by_forget"
    
    /// 忘记密码
    public static let ForgetPasswordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/forget_password"
    
    /// 登录微信绑定手机号
    public static let AccountWXBindPhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/bind/phone"
    
    /// 微信登录邦定手机发送验证码
    public static let AccountWXLoginSendPhoneAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/bind/phone/send_verification_code"
    
    /// 登录修改密码， 【用于微信登录 后的 设置密码】
    public static let AccountWXLoginSetPassowrdAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/init_password"

    /// 修改用户名校验密码
    public static let CheckPassowordAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_info/check_password"

    /// 我的---账户与安全---修改密码
    public static let AccountMineUpdatePassowrdAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/update_password"
    
    /// 账号退出
    public static let AccountLoginOutAPI = "\(S_HOST_BASE_USE)/v\(S_VERSION)/login/login_out"

    /// 检查用户是否可以注销
    public static let AccountDeleteCheck = "\(S_HOST_BASE_USE)/v\(S_VERSION)/users/user_cancel_check"

    /// 最终提交用户注销请求
    public static let AccountFinalRquest = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_destruction/"
    
    /// 用户撤销注销接口
    public static let AccountRevokeDeleteRquest = "\(S_HOST_BASE_USE)/v\(S_VERSION)/user_destruction/revoke"
    
    /// 发送当前登录账号验证码
    public static let AccountOfCurrentSendCode = "\(S_HOST_BASE_USE)/v\(S_VERSION)/sms/send_current_vcode"
    /// 校验验证码和手机号
    public static let AccountOfCurrentCheck = "\(S_HOST_BASE_USE)/v\(S_VERSION)/sms/verify_current_vcode"

}


// MARK: **********************************消息中心模块接口**********************************
public let S_HOST_MSG = "/api-message"

struct HFMsgAPI {
    /// 接收-获取消息类型列表
    public static let MsgTypeAPI = "\(S_HOST_MSG)/v\(S_VERSION)/par_my_msg/get_msg_type"

    /// 接收-获取指定类型的消息列表
    public static let MsgListAPI = "\(S_HOST_MSG)/v\(S_VERSION)/par_my_msg/receive_msg_list"

    /// 接收-获取消息详情
    public static let MsgDetailAPI = "\(S_HOST_MSG)/v\(S_VERSION)/par_my_msg/receive_msg_detail"

    /// 接收-一键已读
    public static let MsgSetReadedAPI = "\(S_HOST_MSG)/v\(S_VERSION)/par_my_msg/upd_read_all"

    /// 接收-删除消息
    public static let MsgDeleteAPI = "\(S_HOST_MSG)/v\(S_VERSION)/par_my_msg/del_receive_msg"

    /// 未读消息数量查询
    public static let MsgUnReadNumAPI = "\(S_HOST_MSG)/v\(S_VERSION)/par_my_msg/get_no_read_msg_cnt"
    
    
}


// MARK: **********************************云家园**********************************
public let S_HOST_CLOUD_HOME = "/api-cloud-home"

struct HFCloudHomeAPI {

    
    /// 获取服务器时间
    public static let GetSystemTimeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/utils/get_server_time"

    /// 获取年级列表
    public static let GetGradeListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/utils/get_grade_list"

    /// 班级信息列表
    public static let GetKiClassInfoAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/utils/get_class_list"
    
    /// 获取幼儿园年级列表
    public static let GetKiGradeListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/utils/get_kg_grade_list"

    /// 根据日期获取月份周数
    public static let GetMonthWeekAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/utils/get_week_in_month_by_date"

    
    // MARK: 园长
    
    /// 首页聚合接口
    public static let getKindergartenHomeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/kindergarten/kindergarten_home_page"
    
    /// 云家园首页聚合接口
    public static let getKindergartenCloudHomeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/kindergarten/kindergarten_cloud_home_page"
    
    /// 获取课程表
    public static let KiGetSchduleAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/grown/grown_action_schedule/find_by_params"
    
    /// 教育活动列表条件查询
    public static let KiGetActivityListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/grown/grown_action_schedule_detail/search"
    
    /// 教育活动详情
    public static let KiGetActivityDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/grown/grown_action/detail"
    
    /// 展示课列表条件查询
    public static let KIGetDisPlayClassListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/show_action/show_action_info/search"
    
    /// 互动活动列表
    public static let getKindergartenInteractionListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/kindergarten/kindergarten_interaction_info/search_group"
    
    /// 互动活动详情
    public static let getKindergartenInteractionDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app/kindergarten/kindergarten_interaction_info/detail"
    
    /// 报告详情
    public static let getKindergartenReportDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/kindergarten_app//kindergarten/teacher_report/detail"

    
    // MARK: 教师
    
    /// 首页聚合接口
    public static let getTeacherHomeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/index/home"
    
    /// 云家园首页聚合接口
    public static let getTeacherCloudHomeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/index/chome"
    
    /// 获取课程表
    public static let TeacherGetSchduleAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/grown/grown_action_schedule/find_by_params"
    
    /// 教育活动列表条件查询
    public static let TeacherGetActivityListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/grown/grown_action_schedule_detail/search"
    
    /// 教育活动详情
    public static let TeacherGetActivityDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/grown/grown_action/detail"
    
    /// 展示课列表条件查询
    public static let TeacherGetDisPlayClassListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/show_action/show_action_info/search"
    
    /// 展示课教育活动详情
    public static let KIGetDisPlayClassDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/show_action/show_action_info/detail"
    
    /// 互动活动列表
    public static let getTeacherInteractionListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/kindergarten/kindergarten_interaction_info/search_group"

    /// 根据网宿视频id换视频信息
    public static let GetPlayUrlAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/utils/get_video_by_id"

    /// 获取互动任务列表
    public static let GetInteractiveTasksAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/common/task/search"
    
    /// 互动活动详情
    public static let getTeacherInteractionDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/kindergarten/kindergarten_interaction_info/detail"
    
    /// 获取配置的科目
    public static let GetConfigSubjectAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/hf_web/config/config_subject/get_all_data"
    
    /// 开放预约
    public static let OpenSubscribeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/kindergarten/kindergarten_interaction_info"
    
    /// 互动营小任务列表
    public static let InteractTaskListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/grown/grown_action_task/get_teacher_list"
    
    /// 获取开放预约二级联动数据(科目-年级)
    public static let getOpenDataCsGrAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/kindergarten/kindergarten_interaction_info/get_open_data"
    
    /// 获取互动形式
    public static let getInteractionSettingListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/config/interaction/setting_list"
    
    /// 发送、保存互动报告
    public static let SendTeacherReportAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/kindergarten/teacher_report/send"
    
    /// 报告详情
    public static let getTeacherReportDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/teacher_app/kindergarten/teacher_report/detail"
    
    
    // MARK: 家长
    
    /// 首页聚合接口
    public static let getParentHomeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/page/index/home_page"
    
    /// 云家园首页聚合接口
    public static let getParentCloudHomeAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/page/index/chome_page"
    
    /// 互动活动列表
    public static let getParentInteractionListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction_info/search"
    
    /// 互动营小任务列表
    public static let getParentInteractTaskListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/grown/grown_action_task/get_task_list"
    
    /// 我参与的互动营活动列表接口
    public static let getParentJoinInteractionListAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction_signup/search_by_type"
    
    /// 互动活动详情
    public static let getParentInteractionDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction_info/detail"
    
    /// 报告详情
    public static let getParentReportDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/teacher_report/detail"
    
    /// 预约
    public static let subscribeInteractiveAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction/add_signup"
    
    /// 取消预约
    public static let cancelSubscribeInteractiveAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction/cancel_signup"
    
    /// 评价
    public static let createParentInteractiveReportAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction_report_parent/create"
    
    /// 获取评价详情
    public static let getInteractiveParentReportDetailAPI = "\(S_HOST_CLOUD_HOME)/v\(S_VERSION)/parents_app/kindergarten/kindergarten_interaction_report_parent/detail"
}


// MARK: **********************************订单**********************************
public let S_HOST_BIZ_ORDER = "/api-biz-order"

struct HFOrderAPI {
    
    // 园长端app-我的订单-查询列表
    public static let GetPrincipalMyBusOrderListAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/directororder/director/get_my_order_list"
    
    // 园长端app-取消订单
    public static let cancelPrincipalBusOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/directororder/upd_order_cancel"
    
    // 园长端app-删除订单
    public static let delPrincipalBusOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/directororder/del_order"
    
    // 教师端app-我的订单-查询列表
    public static let GetTeacherMyBusOrderListAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/teacherorder/get_my_order_list"
    
    // 教师端app-取消订单
    public static let cancelTeacherBusOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/teacherorder/upd_order_cancel"
    
    // 教师端app-删除订单
    public static let delTeacherBusOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/teacherorder/del_order"
    
    // 家长端app-我的订单-查询列表
    public static let GetParentMyBusOrderListAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/parentorder/business/get_my_order_list"
    
    // 家长端app-取消订单
    public static let cancelParentBusOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/parentorder/business/upd_order_cancel"
    
    // 家长端app-删除订单
    public static let delParentBusOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/parentorder/business/del_order"
    
    // 家长端app-我的订单五色宝石-查询列表
    public static let GetMyGemOrderListAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/parentorder/gem/get_my_order_list"
    
    // 家长端app-五色宝石取消订单
    public static let cancelGemOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/parentorder/gem/upd_order_cancel"
    
    // 家长端app-五色宝石删除订单
    public static let delGemOrderAPI = "\(S_HOST_BIZ_ORDER)/v\(S_VERSION)/parentorder/gem/del_order"
}

// MARK: **********************************虚拟币相关**********************************
public let S_HOST_COIN = "/api-vcoin"

struct HFCoinAPI {
    
    // 宝石账户信息和配置信息列表
    public static let GetCoinAccountConfigAPI = "\(S_HOST_COIN)/v\(S_VERSION)/gem_product/app/get_account_product_info"
    
    // 宝石收支记录
    public static let GetCoinPaymentsRecordsAPI = "\(S_HOST_COIN)/v\(S_VERSION)/gem_account_log/get_my_gem_account_log"
    
    // 获取我的虚拟币-宝石余额
    public static let GetGemBalance = "\(S_HOST_COIN)/v\(S_VERSION)/my_gem_account_balanceg"
    
    
}

