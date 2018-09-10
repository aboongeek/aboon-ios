//
//  TutorialViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/09/10.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift

class TutorialViewController: UIPageViewController, UIPageViewControllerDataSource {

    let disposeBag = DisposeBag()
    var pages: [TutorialPageViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let range = 0...3
        pages = range.map { i -> TutorialPageViewController in
            return TutorialPageViewController(page: i, isLast: (i == range.last!))
        }
        
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        pages
            .last!
            .finishObservable
            .subscribe(onNext: { [weak self] isTapped in
                guard let `self` = self else { return }
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! TutorialPageViewController).page
        if index > 0 {
            return pages[index-1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! TutorialPageViewController).page
        if index < pages.count-1 {
            return pages[index+1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
