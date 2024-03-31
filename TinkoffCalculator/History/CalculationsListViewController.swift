//
//  CalculationsListViewController.swift
//  TinkoffCalculator
//
//  Created by macOS on 03.03.2024.
//

import UIKit

class CalculationsListViewController: UIViewController {
    
    var calculations: [Calculation] = []
    
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor.systemGray5
        /*let tableHeaderView = UIView()
        
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30)
        tableView.tableHeaderView = tableHeaderView*/
        /*let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 0, width: tableHeaderView.frame.width-10, height: tableHeaderView.frame.height)
        //label.text = getDate()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black*/
        /*tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))*/
        
        /*var countCalculations: Int
            countCalculations = calculations.count
            if countCalculations != 0 {
                tableHeaderView.addSubview(label)
                tableHeaderView.backgroundColor = UIColor.systemBlue
            } else {
                return
            }*/
  
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func expressionToString(_ expression: [CalculationHistoryItem])-> String {
        var result = ""
        
        for operand in expression {
            switch operand {
            case let .number(value):
                result += String(value) + " "
                
            case let .operation(value):
                result += value.rawValue + " "
                
            }
        }
        return result
    }
}


extension CalculationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  "Дата вычисления"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

extension CalculationsListViewController: UITableViewDataSource {
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
     }
     
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return calculations.count
}
  
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        let historyItem = calculations[indexPath.section]
        cell.configure(with: expressionToString(historyItem.expression), result: String(historyItem.result))
        
        return cell
    }

    
}
