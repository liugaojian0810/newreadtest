//
//  HFClassSelectController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

enum ShowType {
    
    case selClass
    case acticity
    case approval //审批筛选
}

class HFClassSelectController: HFNewBaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var showType: ShowType?
    var activitys: [OnedayFlowActivityModel]?
    
    var approvalSituation: Int = 0 //审批情况 0是未处理 1是已处理
    var untreateds: [String]? //未处理
    var treateds: [[String]]? //已处理
    var selectedIndex = IndexPath(item: -1, section: -1)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topConstrint: NSLayoutConstraint!
    @IBOutlet weak var bottomBgView: UIView!
    var selClosure: OptionClosureInt?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
    }
    
    func config() -> Void {
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        if self.showType == ShowType.acticity {
            self.title = "请选择"
            self.topConstrint.constant = 232
            bottomBgView.isHidden = false
        }else if self.showType == ShowType.approval {
            self.title = "筛选"
            self.topConstrint.constant = 232
            bottomBgView.isHidden = false
            self.collectionView.isMultipleTouchEnabled = true
        }else{
            self.title = "请选择要分配的班级"
            self.topConstrint.constant = 0
            bottomBgView.isHidden = true
        }
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 16
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.itemSize = CGSize(width: (S_SCREEN_WIDTH - 34) / 3, height: 32)
        flowlayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.collectionView.setCollectionViewLayout(flowlayout, animated: true)
        self.collectionView.register(byIdentifiers: ["HFClassSelectItemCell"])
        self.collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ClassSelectCollectionViewCell")
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch showType {
        case .selClass:
            return 3
        case .acticity:
            return 1
        case .approval:
            if  approvalSituation == 0{
                return 1
            }else{
                return treateds!.count
            }
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch showType {
        case .selClass:
            return 5
        case .acticity:
            return self.activitys!.count
        case .approval:
            if  approvalSituation == 0{
                return untreateds!.count
            }else{
                return treateds![section].count
            }
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HFClassSelectItemCell", for: indexPath) as! HFClassSelectItemCell
        if self.showType == ShowType.acticity {
            cell.cornerRadiusnew = 8.0
            cell.textLab.text = self.activitys![indexPath.row].dppName
        }else if self.showType == ShowType.approval{
            if  approvalSituation == 0 {
                cell.cornerRadiusnew = 8.0
                cell.textLab.text = self.untreateds![indexPath.row]
            }else{
                cell.cornerRadiusnew = 8.0
                cell.textLab.text = self.treateds![indexPath.section][indexPath.row]
            }
        }
        else{
            cell.cornerRadiusnew = 16.0
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if self.showType == ShowType.acticity {
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: S_SCREEN_WIDTH - 32, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if self.showType == ShowType.acticity {
            return UICollectionReusableView()
        }else{
            let noContent = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ClassSelectCollectionViewCell", for: indexPath)
            let label = UILabel(frame: CGRect(x: 16, y: 0, width: S_SCREEN_WIDTH - 32, height: 50))
            if self.showType == ShowType.approval {
                switch indexPath.section {
                case 0:
                    label.text = "状态"
                default:
                    label.text = "审批事项"
                }
            }else{
                switch indexPath.section {
                case 0:
                    label.text = "小班"
                case 1:
                    label.text = "中班"
                default:
                    label.text = "大班"
                }
            }
            label.textColor = .colorWithHexString("27323F")
            label.font = .boldSystemFont(ofSize: 16)
            noContent.addSubview(label)
            return noContent
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch showType {
        case .selClass:
            print("")
            
        case .acticity:
            print("")
            
        case .approval:
            print("")
        default:
            print("")
        }
    }
    
    // MARK: UICollectionViewFlowLayout
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
    ///确定按钮点击
    @IBAction func confirm(_ sender: UIButton) {
        
        let selects = self.collectionView.indexPathsForSelectedItems

        if let sel = selects, sel.count != 0 {
            if self.selClosure != nil {
                let indexPath = sel[0]
                self.selClosure!(indexPath.row)
            }
        }else{
            if self.selClosure != nil {
                self.selClosure!(-1)
            }
        }
        self.dismiss(animated: true, completion: {})
    }
}







