//
//  ViewController.swift
//  TableViewExample
//
//  Created by Денис Холодков on 24.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var names = ["John", "Dima", "Nikita", "Alexey", "Sonya", "Anna", "Elena", "Alexander", "Ivan", "Petr"]
    private var icons = ["pause", "pause", "pause", "pause", "pause", "pause", "pause", "pause", "pause", "pause",]

    // MARK: - Outlets

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        return tableView
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
        textField.placeholder = "Type name here"
        return textField
    }()

    private lazy var buttonAddCell: UIButton = {
       let button = UIButton()
       button.setTitle("Press to add", for: .normal)
       button.backgroundColor = #colorLiteral(red: 0.469851315, green: 0.4130082726, blue: 1, alpha: 1)
       button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
       return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "TableView"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(buttonAddCell)
    }

    private func showAlert() {
        let alert = UIAlertController(
         title: "Ошибка",
         message: "Пустое поле, введите имя",
         preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ок!", style: .cancel, handler: { event in

        }))
        self.present(alert, animated: true)
    }

    @objc private func buttonAction() {
        if !textField.hasText {
           showAlert()
        } else {
            names.append(textField.text ?? "")
            icons.append("pause")
            tableView.reloadData()
            textField.text?.removeAll()
        }
    }

    private func setupLayout() {

        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view)
            $0.left.equalTo(view).offset(20)
            $0.height.equalTo(40)
        }

        buttonAddCell.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.centerX.equalTo(view)
            $0.left.equalTo(view).offset(20)
            $0.height.equalTo(50)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(buttonAddCell.snp.bottom).offset(20)
            $0.right.bottom.left.equalTo(view)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // 10 фиксированное количество ячеек
        names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(systemName: icons[indexPath.row]) // для добавления иконки слева к ячейке таблицы
        return cell
    }
}
