//
//  Asyncs.swift
//  Swift_0828_Demo
//
//  Created by liugaojian on 2020/8/29.
//  Copyright © 2020 liugaojian. All rights reserved.
//

import Foundation

public typealias Task = () -> Void

class Asyncs {
    
    // MARK: 子线程执行
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    
    // MARK: 子线程执行完 回调主线程执行
    public static func async(_ task: @escaping Task, _ mainTask:@escaping Task) {
        _async(task, mainTask)
    }
    
    private static func _async(_ task: @escaping Task, _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    // MARK: 延迟执行
    @discardableResult
    public static func asyncDelay(_ seconds: Double, _ task: @escaping Task) ->DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    
    @discardableResult
    public static func asyncDelay(_ seconds: Double, _ task: @escaping Task, _ mainTask: @escaping Task) ->DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }
    
    private static func _asyncDelay(_ seconds: Double, _ task: @escaping Task, _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds, execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
    
}
