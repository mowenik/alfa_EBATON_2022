//
//  ViewController.swift
//  ebascroll
//
//  Created by Maxim Vitovitsky on 21.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let PARTS_COUNT = 5

    @IBAction func showPrikol(endingOfPrikol: String) {
        // Генерю вьюху для фона. Код генерации вьюхи написал GPT по запросу:
        /*
         "how to generate random kaleidoscope image in swift"
         +
         "Make pixel art image from UIImage in Swift"
         */
        let targetView = generateTargetView()
        view.addSubview(targetView)
        let images = view.asImage().splitIntoRows(rows: PARTS_COUNT)
        targetView.removeFromSuperview()
        
        var partImageViewsToCheck: [UIImageView] = []
        let partHeight = view.frame.size.height / CGFloat(PARTS_COUNT)
        
        for i in 0..<PARTS_COUNT {
            let scroll = UIScrollView(
                frame: CGRect(
                    x: 0, y: partHeight * CGFloat(i), width: view.frame.size.width, height: partHeight
                )
            )
            scroll.contentSize = CGSize(width: 1300, height: partHeight)
            
            let imageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(Int.random(in: 30...800)),
                    y: 0,
                    width: scroll.bounds.width,
                    height: scroll.bounds.height
                )
            )
            imageView.image = images[i]
            scroll.addSubview(imageView)
            
            view.addSubview(scroll)
            
            scroll.setContentOffset(CGPoint(x: CGFloat.random(in: 100...800), y: 0), animated: false)
            partImageViewsToCheck.append(imageView)
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [partImageViewsToCheck] timer in
            let filtered = partImageViewsToCheck.filter { imageView in
                let window = UIApplication.shared.windows.first!
                let frameOnWindow = imageView.convert(imageView.bounds, to: window)
                return abs(frameOnWindow.origin.x) < 5
            }
            
            if filtered.count == partImageViewsToCheck.count {
                timer.invalidate()
                
                let vc = UIStoryboard.instantiateViewController(
                    ofType: UIViewController.self,
                    withIdentifier: "targetController"
                ) as! TargetViewController
                vc.modalPresentationStyle = .fullScreen
                
                vc.configureWith(bgView: targetView, andText: endingOfPrikol)
                
                vc.transitioningDelegate = self
                self.present(vc, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    partImageViewsToCheck.forEach { $0.superview!.removeFromSuperview() }
                }
            }
        }
    }
    
    func generateTargetView() -> UIView {
        let kalView = KaleidoscopeView(
            frame: CGRect(
                x: -100, y: -100,
                width: view.bounds.size.width + 200,
                height: view.bounds.size.height + 200
            )
        )
        return kalView
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeInTransition()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StoragePrikolov.prikols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell")!
        (cell.contentView.subviews[0] as! UILabel).text = StoragePrikolov.prikols[indexPath.row].start
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showPrikol(endingOfPrikol: StoragePrikolov.prikols[indexPath.row].end)
    }
    
}
