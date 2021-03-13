//
//  HFDouble.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/18.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation


//保留小数位数
extension Double {

    func keepDecimal(places:Int) -> Double {

        let divisor = pow(10.0, Double(places))

        return (self * divisor).rounded() / divisor

    }

}

extension Float {

    func keepDecimal(places:Int) -> Float {

        let divisor = pow(10.0, Float(places))

        return (self * divisor).rounded() / divisor

    }

}
