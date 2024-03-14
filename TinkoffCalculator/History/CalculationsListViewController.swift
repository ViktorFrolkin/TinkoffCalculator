//
//  CalculationsListViewController.swift
//  TinkoffCalculator
//
//  Created by macOS on 03.03.2024.
//

import UIKit

class CalculationsListViewController: UIViewController {
    
    var calculations: [(expression: [CalculationHistoryItem], result: Double)] = []
    
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
        let tableHeaderView = UIView()
        let tableFooterView = UIView()
        tableHeaderView.backgroundColor = UIColor.systemBlue
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30)
        tableView.tableHeaderView = tableHeaderView
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 0, width: tableHeaderView.frame.width-10, height: tableHeaderView.frame.height)
        label.text = getDate()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        tableHeaderView.addSubview(label)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
       
        func getDate() -> String {
            let date = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let formatDate = formatter.string(from: date as Date)
            return formatDate
        }
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

extension CalculationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        let historyItem = calculations[indexPath.row]
        cell.configure(with: expressionToString(historyItem.expression), result: String(historyItem.result))
        return cell
    }
   // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return "hxx"
    
    
}
