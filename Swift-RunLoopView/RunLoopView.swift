//
//  RunLoopView.swift
//  Swift-RunLoopView
//
//  Created by aa on 16/11/17.
//  Copyright © 2016年 aa. All rights reserved.
//

import UIKit

class RunLoopView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var imgAry: NSArray?
    var afterAry: NSMutableArray?
    var loopCollectionView: UICollectionView?
    var pageControl: UIPageControl?
    var _number: Int?
    
    
    
    func getAfterData() -> Void {
        if (self.afterAry == nil) {
            self.afterAry = NSMutableArray.init(capacity: 0)
            self.afterAry?.addObjectsFromArray(self.imgAry! as [AnyObject])
            self.afterAry?.insertObject((self.imgAry?.lastObject)!, atIndex: 0)
            self.afterAry?.addObject((self.imgAry?.objectAtIndex(0))!)
            pageControl?.numberOfPages = (self.imgAry?.count)!
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.orangeColor()
        _number = 0
        
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .Horizontal
        
        loopCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        loopCollectionView!.delegate = self
        loopCollectionView!.dataSource = self
        loopCollectionView!.pagingEnabled = true
        loopCollectionView!.backgroundColor = UIColor.purpleColor()
        loopCollectionView!.showsHorizontalScrollIndicator = false
        loopCollectionView!.registerClass(UICollectionViewCell().classForCoder, forCellWithReuseIdentifier: "myCell")
        self.addSubview(loopCollectionView!)
        
        pageControl = UIPageControl.init(frame: CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20))
        pageControl?.currentPage = 0
        pageControl?.pageIndicatorTintColor = UIColor.purpleColor()
        pageControl?.currentPageIndicatorTintColor = UIColor.blueColor()
        self.addSubview(pageControl!)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.afterAry?.count)!
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(self.frame.width, self.frame.height)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath)
        
        let imgView = UIImageView.init(frame: self.bounds)
        imgView.image = UIImage.init(imageLiteral: self.afterAry!.objectAtIndex(indexPath.item) as! String)
        cell.contentView.addSubview(imgView)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("滑动到当前第\(_number!)页")
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //图片减速时，更换轮播页数
        var index = Int(scrollView.contentOffset.x/self.frame.size.width)
        
        //滑动到倒数第二页时，继续向后滑动
        if index == (self.afterAry?.count)!-1 {
            index = 1
            loopCollectionView?.scrollToItemAtIndexPath(NSIndexPath.init(forItem: index, inSection: 0), atScrollPosition: .None, animated: false)
        }
        //若滑动到第一页，再向前滑动
        if index == 0 {
            index = (self.afterAry?.count)!-2
            loopCollectionView?.scrollToItemAtIndexPath(NSIndexPath.init(forItem: index, inSection: 0), atScrollPosition: .None, animated: false)
        }
        print("当前---：\(index)")
        pageControl?.currentPage = index-1
        _number = index-1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.getAfterData()
        print(self.afterAry)
        if loopCollectionView!.contentOffset.x < self.frame.size.width {
            let indexpath = NSIndexPath.init(forItem: 1, inSection: 0)
            loopCollectionView!.scrollToItemAtIndexPath(indexpath, atScrollPosition: .None, animated: false)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
