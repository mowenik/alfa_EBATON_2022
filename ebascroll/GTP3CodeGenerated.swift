//
//  GTP3CodeGenerated.swift
//  ebascroll
//
//  Created by Maxim Vitovitsky on 21.12.2022.
//

import UIKit

/*
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАХУЕВЕРЧЕНОНАХУЕВЕРЧЕНОНАХУЕВЕРЧЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 ВСЁ ЭТО НАГЕНЕРЕНО С ПОМОЩЬЮ ChatGPT в обёртке MacGPT
 */

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}

class KaleidoscopeView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.addRect(bounds)
        context?.clip()
        
        let image = generateRandomImage()
        image.draw(in: bounds)
    }
    
    func generateRandomImage() -> UIImage {
        let size = CGSize(width: 400, height: 400)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colors = [UIColor.random.cgColor, UIColor.random.cgColor]
            let locations: [CGFloat] = [0.0, 1.0]
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
            let startPoint = CGPoint(x: 0, y: 0)
            let endPoint = CGPoint(x: size.width, y: size.height)
            context.cgContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        }
        return image.pixelated(scale: 135)!
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

extension UIImage {
    func pixelated(scale: CGFloat) -> UIImage? {
        let ciImage = CIImage(image: self)
        let filter = CIFilter(name: "CIPixellate")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(scale, forKey: kCIInputScaleKey)
        let ciContext = CIContext()
        guard let outputImage = filter?.outputImage else { return nil }
        guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

extension UIStoryboard {
    static func instantiateViewController<T: UIViewController>(ofType type: T.Type, withIdentifier identifier: String) -> T {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
    }
}

extension UIImage {
    func splitIntoRows(rows: Int) -> [UIImage] {
        let rowHeight = CGFloat(cgImage!.height) / CGFloat(rows)
        var images: [UIImage] = []
        for i in 0..<rows {
            let rect = CGRect(x: 0, y: rowHeight * CGFloat(i), width: CGFloat(cgImage!.width), height: rowHeight)
            let image = cgImage!.cropping(to: rect)
            images.append(UIImage(cgImage: image!))
        }
        return images
    }
}

class FadeInTransition: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toViewController = transitionContext.viewController(forKey: .to)
      
    toViewController?.view.alpha = 0
    
    // Add the toViewController's view to the container view
    containerView.addSubview(toViewController!.view)
    
    // Animate the toViewController's view sliding in from the right
    UIView.animate(withDuration: 1, animations: {
      toViewController?.view.alpha = 1
    }, completion: { finished in
      // Mark the transition as complete
      transitionContext.completeTransition(finished)
    })
  }
}
