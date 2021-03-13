//
//  HFMyCardPackageCell.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMyCardPackageCell: UITableViewCell, UIScrollViewDelegate {
    
    var clikClosure: OptionClosureString?
    @IBOutlet weak var bgView: UIView!
    var cardNum: Int = 0
    
    var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var corverView: UIView = {
        let corverView = UIView()
        corverView.backgroundColor = .white
        return corverView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.addSubview(mainScrollView)
        self.mainScrollView.delegate = self
        self.mainScrollView.addSubview(corverView)
    }

    func addCard(with card: HFMemCardPackageList) {
        cardNum = card.memCardPackageDetailList?.count ?? 0
        self.mainScrollView.frame = CGRect(x: 12, y: 12, width: S_SCREEN_WIDTH - 24, height: 133+12)
        self.corverView.frame = CGRect(x: 12, y: 0, width: S_SCREEN_WIDTH - 36, height: 133+12)
        for subItem in self.corverView.subviews {
            if subItem.isKind(of: HFCardPackageSubItem.classForCoder()) {
                subItem.removeSubviews()
            }
        }
        for index in 0..<cardNum {
            let itemView = Bundle.main.loadNibNamed("HFCardPackageSubItem", owner: self, options: nil)?.last as! HFCardPackageSubItem
            itemView.cardPackage = card.memCardPackageDetailList![index]
            itemView.clickClosure = {
                if self.clikClosure != nil {
                    self.clikClosure!("\(index)")
                }
            }
            itemView.frame = CGRect(x: CGFloat(index)*((S_SCREEN_WIDTH-106)+12), y: 12, width: S_SCREEN_WIDTH-106, height: 133)
            itemView.tag = index + 100
            self.corverView.addSubview(itemView)
        }
        self.mainScrollView.contentSize = CGSize(width: (cardNum)*((Int(S_SCREEN_WIDTH)-106)+12) + 12, height: 133+12)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
//        let page = mainScrollView.page
//        print(page)
//        let pageNum = mainScrollView.contentOffset.x/(S_SCREEN_WIDTH - 36) + 0.5
//        let result = Int(pageNum)
//        print("page num = \(result)")
//        if result == 0 {
//            mainScrollView.jk_contentOffsetX = 0
//        }else if result == cardNum - 1 {
//
//        }else{
//            mainScrollView.jk_contentOffsetX = (S_SCREEN_WIDTH - 36) * CGFloat(result)
//            for subItem in self.corverView.subviews {
//                if subItem.isKind(of: HFCardPackageSubItem.classForCoder()) {
//                    if subItem.tag == 100 + result {
//                        mainScrollView.jk_contentOffsetX = subItem.centerX
//                    }
//                }
//            }
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
