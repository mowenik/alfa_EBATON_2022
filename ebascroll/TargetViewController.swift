//
//  TargetViewController.swift
//  ebascroll
//
//  Created by Maxim Vitovitsky on 21.12.2022.
//

import UIKit

class TargetViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var text: String = ""
    
    func configureWith(bgView: UIView, andText text: String) {
        self.text = text
        view.addSubview(bgView)
        view.bringSubviewToFront(titleLabel)
        view.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBAG))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = self.text
    }
    
    @objc func goBAG() {
        dismiss(animated: true)
    }
    
}
