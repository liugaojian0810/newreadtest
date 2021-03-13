//
//  HFRichTextAleatViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFRichTextAleatViewController: UIViewController {

    public var titleText: String?
    public var richText: NSAttributedString?
    public var item1Title: String?
    public var item2Title: String?
    
    @IBOutlet private weak var titleLab: UILabel!
    @IBOutlet private weak var contentTextLab: UILabel!
    @IBOutlet private weak var itemBtn1: UIButton!
    @IBOutlet private weak var itemBtn2: UIButton!
    @IBOutlet private weak var cancelBtn: UIButton!
    
    var selectItem1: OptionClosure?
    var selectItem2: OptionClosure?
    var cancel: OptionClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.titleLab.text = self.titleText
        self.contentTextLab.attributedText = richText! as NSAttributedString
        
        self.itemBtn1.layer.borderColor = UIColor.hexColor(0xFF844B).cgColor
        self.itemBtn1.setTitleColor(UIColor.hexColor(0xFF844B), for: .normal)
        self.itemBtn1.layer.borderWidth = 1
        self.itemBtn1.setTitle(self.item1Title , for: .normal)
        
        self.itemBtn2.backgroundColor = UIColor.hexColor(0xFF844B)
        self.itemBtn2.setTitleColor(UIColor.hexColor(0xFFFFFF), for: .normal)
        self.itemBtn2.setTitle(self.item2Title, for: .normal)
    }
    
    @IBAction func clickItem1(_ sender: UIButton) {
        if selectItem1 != nil {
            selectItem1!()
        }
    }
    
    @IBAction func clickItem2(_ sender: UIButton) {
        if selectItem2 != nil {
            selectItem2!()
        }
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        if cancel != nil {
            cancel!()
        }
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
