//
//  HFIdentityAuthResultController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/3.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFIdentityAuthResultController: HFNewBaseViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var operationBtn: UIButton!
    
    @IBOutlet weak var resultMessageLB: UILabel!
    var operationClosure: OptionClosure?
    var state: Int = 1
    var reTryClosure: OptionClosure?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "认证结果"
        //失败和成功
        if state == 0 {
            self.resultMessageLB.text = "认证失败"
            self.resultImageView.image = UIImage(named: "icon／toast／cuowu")
            self.bottomView.isHidden = false
            self.operationBtn.setTitle("重试", for: .normal)

        } else {
            self.resultMessageLB.text = "认证成功"
            self.resultImageView.image = UIImage(named: "icon／toast／duihao")
            self.bottomView.isHidden = true
            self.operationBtn.setTitle("知道了", for: .normal)

        }
    }
    
    
    @IBAction func opeBtnclicked(_ sender: UIButton) {
        if state == 0 {
            if self.reTryClosure != nil {
                self.reTryClosure!()
            }
            self.navigationController?.popViewController(animated: true)
        }else{
            
            for (index, vc) in (self.navigationController?.viewControllers ?? []).enumerated() {
                if vc.isKind(of: HFIdentityAuthController.classForCoder()) {
                    let temp = self.navigationController?.viewControllers[index - 1] as! HFNewBaseViewController
                    self.navigationController?.popToViewController(temp, animated: true)
                    break
                }
            }
        }
//        if let closure = operationClosure {
//            closure()
//        }
        
    }
    
}
