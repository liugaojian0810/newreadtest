//
//  HFSwiftCountDown.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/12/29.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

import Foundation

class HFSwiftCountDown: NSObject {
    
    var codeTimer: DispatchSourceTimer?
    
    /// GCD定时器倒计时
    ///
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - repeatCount: 重复次数
    ///   - handler: 循环事件,闭包参数: 1.timer 2.剩余执行次数
    @objc func countDown(timeInterval: Double, repeatCount: Int, handler: @escaping (DispatchSourceTimer?, Int) -> Void) {
        
        if repeatCount <= 0 {
            return
        }
        codeTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        codeTimer?.schedule(deadline: .now(), repeating: timeInterval)
        codeTimer?.setEventHandler {
            count -= 1
            DispatchQueue.main.async {
                handler(self.codeTimer, count)
            }
            if count == 0 {
                self.codeTimer?.cancel()
            }
        }
        codeTimer?.resume()
    }
    
    @objc func stop() -> Void {
        codeTimer?.cancel()
    }
}
