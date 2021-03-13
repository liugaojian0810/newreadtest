//
//  HFMyOrderViewController.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/28.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFMyOrderViewController: HFNewBaseViewController {
    
    var segmentedDataSource: JXSegmentedTitleDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    
    
    func config() -> Void {
        title = "我的订单"
        
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource?.titles = ["宝石订单","产品订单"]
        segmentedDataSource?.titleNormalColor = .hexColor(0x303030)
        segmentedDataSource?.titleNormalFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        segmentedDataSource?.titleSelectedColor = .colorMain()
        segmentedDataSource?.titleSelectedFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        segmentedDataSource?.itemWidth = S_SCREEN_WIDTH / 3
        segmentedDataSource?.itemSpacing = 0
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 16
        indicator.indicatorHeight = 3
        indicator.indicatorColor = .colorMain()
        indicator.verticalOffset = 12
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.indicators = [indicator]
        segmentedView.backgroundColor = .white
        view.addSubview(segmentedView)

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: S_NAV_HEIGHT, width: view.bounds.size.width, height: 56)
        listContainerView.frame = CGRect(x: 0, y: S_NAV_HEIGHT + 56, width: view.bounds.size.width, height: view.bounds.size.height - S_NAV_HEIGHT - 56)
    }
    
    
    
    
    
}

extension HFMyOrderViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension HFMyOrderViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = HFOrderListViewController()
        if index == 0 {
            vc.viewModel.orderType = .gem
        }else if index == 1 {
            vc.viewModel.orderType = .bus_parent
        }
        return vc
    }
}
