//
//  CalculationsListViewController.swift
//  TinkoffCalculator
//
//  Created by macOS on 03.03.2024.
//

import UIKit

class CalculationsListViewController: UIViewController {
    
    var result: String?
    
    @IBOutlet weak var calculationLabel: UILabel!
    
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if result != "0"{
            calculationLabel.text = result} else {
                calculationLabel.text = "NoData"
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

