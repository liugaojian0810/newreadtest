//
//  HFPopupManager.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/7.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation

@objc class HFPopupManager: NSObject {
    
    @objc static let shared = HFPopupManager()
    
    var currentViewController: UIViewController?
    
    private var lastCiId = "" // 记录最后请求时的宝宝id
    
    override init() {
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 切换视图
    @objc func enterHomePage(viewController: UIViewController) -> Void {
        
        HFPopupManager.shared.currentViewController = viewController
        
        if viewController.tabBarController != nil && viewController.tabBarController!.isVisible {
            self.loadTeacherInviteStatus()
        }
    }
    
    /// 邀请结果弹窗
    var didShowInviteResultPopView = false
    lazy var inviteResultPopView: HFInviteResultPopView = {
        let inviteResultPopView = Bundle.main.loadNibNamed("HFInviteResultPopView", owner: nil, options: nil)?.last as! HFInviteResultPopView
        inviteResultPopView.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: S_SCREEN_HEIGHT)
        inviteResultPopView.closeClosure = { [weak self] in
            // 关闭
            self!.inviteResultPopView.removeFromSuperview()
        }
        inviteResultPopView.rejectClosure = {
            // 拒绝
            HFPopupDataManager.rejectJoinInvition(ilStatus: 7) {
                self.inviteResultPopView.removeFromSuperview()
            } _: {
            }
        }
        inviteResultPopView.agreeClosure = {
            // 接受
            HFPopupDataManager.rejectJoinInvition(ilStatus: 3) {
                inviteResultPopView.status = inviteResultPopView.joinResultModel?.ciComeStatus == 1 ? .inviteJoin1 : .inviteJoin2
                // 同步宝宝列表
                HFBabyViewModel.syncChilds {
                    print("同步宝宝列表成功")
                } failClosure: {
                    print("同步宝宝列表成功")
                }
            } _: {
            }
        }
        inviteResultPopView.entryTableClosure = { [weak self] in
            // 填写教师入职申请表
            self!.inviteResultPopView.removeFromSuperview()
            if self?.currentViewController == nil {
                self?.currentViewController =  UIViewController.currentViewController()
            }
            let vc = HFBabyEntryTableViewController()
            self?.currentViewController?.navigationController?.pushViewController(vc, animated: true)
        }
        inviteResultPopView.status = .agreeJoin
        return inviteResultPopView
    }()
    
    /// 入职结果弹窗
    var didShowEntryResultPopView = false
    lazy var entryResultPopView: HFEntryResultPopView = {
        let entryResultPopView = Bundle.main.loadNibNamed("HFEntryResultPopView", owner: nil, options: nil)?.last as! HFEntryResultPopView
        entryResultPopView.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: S_SCREEN_HEIGHT)
        entryResultPopView.closeClosure = { [weak self] in
            // 关闭
            self!.entryResultPopView.removeFromSuperview()
        }
        entryResultPopView.exitClosure = { [weak self] in
            // 退出
            self!.entryResultPopView.removeFromSuperview()
        }
        entryResultPopView.updateClosure = { [weak self] in
            // 修改
            self!.entryResultPopView.removeFromSuperview()
            if self?.currentViewController == nil {
                self?.currentViewController =  UIViewController.currentViewController()
            }
            // TODO: 需要判断拒绝类型，跳转入园申请表修改还是入园邀请修改
            if entryResultPopView.joinResultModel?.ilWay == 0 {
                let vc = HFBabyEntryTableViewController()
                self?.currentViewController?.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = HFBabyEntryTableViewController()
                self?.currentViewController?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        entryResultPopView.status = .reject
        return entryResultPopView
    }()
    
    /// 邀请状态查询
    func loadTeacherInviteStatus() -> Void {
        HFPopupDataManager.loadBabyJoinResult {
            print("加载邀请状态成功")
            self.showTeacherInviteStatus()
        } _: {
            print("加载邀请状态失败")
        }
    }
    
    /// 加载当前选中宝宝邀请状态
    func loadCurrentBabyInviteStatus() -> Void {
        let babyModel = HFBabyViewModel.shared.currentBaby
        if babyModel != nil {
            // 宝宝选择更新，且宝宝状态为已入学
            if self.lastCiId != babyModel?.ciId && babyModel!.isEntranceKg == 1{
                self.didShowInviteResultPopView = false
                self.didShowEntryResultPopView = false
                HFPopupDataManager.loadBabyJoinResult(ciId: babyModel!.ciId) {
                    print("加载邀请状态成功:\(babyModel!.ciId)")
                    self.showTeacherInviteStatus()
                } _: {
                    print("加载邀请状态失败:\(babyModel!.ciId)")
                }
                self.lastCiId = babyModel!.ciId
            }
        }
    }
    
    /// 显示邀请结果弹窗
    func showTeacherInviteStatus() -> Void {
        let model = HFPopupDataManager.shared.joinResultModel
        if model == nil {
            return
        }
        
        // 0未读;1已读;3已接受;5未接受;7拒绝
        if model!.ilStatus == 0 || model!.ilStatus == 3 || model!.ilStatus == 5 {
            // 未读或未接受，显示邀请弹窗
            if !didShowInviteResultPopView {
                didShowInviteResultPopView = !didShowInviteResultPopView
                let popView = HFPopupManager.shared.inviteResultPopView
                popView.joinResultModel = model
                if model?.ilStatus == 3 {
                    popView.status = model?.ciComeStatus == 1 ? .inviteJoin1 : .inviteJoin2
                }else{
                    popView.status = .agreeJoin
                }
                UIApplication.shared.keyWindow!.addSubview(popView)
                UIApplication.shared.keyWindow!.bringSubviewToFront(popView)
            }
        }
        
        if model!.ilStatus == 7 {
            // 已拒绝，显示拒绝原因
            if !didShowEntryResultPopView {
                didShowEntryResultPopView = !didShowEntryResultPopView
                let popView = HFPopupManager.shared.entryResultPopView
                popView.joinResultModel = model
                UIApplication.shared.keyWindow!.addSubview(popView)
                UIApplication.shared.keyWindow!.bringSubviewToFront(popView)
            }
        }
    }
}
