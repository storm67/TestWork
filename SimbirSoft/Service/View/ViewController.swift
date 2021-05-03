//
//  ViewController.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, Switcher {
    
    var factory: MainFactoryResolver
    var coordinator: CoordinatorCommands
    var viewModel: CalendarViewModel
    
    init(factory: MainFactoryResolver, coordinator: CoordinatorCommands,viewModel: CalendarViewModel) {
        self.factory = factory
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().collectionView.delegate = self
        view().collectionView.dataSource = self
        view().tableView.delegate = self
        view().tableView.dataSource = self
        resolveDays()
        view().delegate = self
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action:#selector(nextController), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        viewModel.addValues()
    }
    
    @objc func nextController() {
        coordinator.nextViewController()
    }
    
    func view() -> MainView {
        return view as! MainView
    }
    
    override func loadView() {
        view = factory.resolveMainView()
    }
    
    func resolveDays() {
        viewModel.addDates() { [weak self] in
            guard let calendar = self?.viewModel.calendarModel else { return }
            self?.daysChanger()
            self?.view().collectionView.reloadData()
            self?.view().update(year: calendar.year, month: calendar.months[calendar.current].capitalized)
        }
    }
    
    func daysChanger() {
        guard let calendar = self.viewModel.calendarModel else { return }
        viewModel.indent(year: calendar.year, month: calendar.current + 1, day: calendar.days?[1] ?? 0)
    }
    
    func switchNext(sender: UIButton) {
        guard let calendar = self.viewModel.calendarModel else { return }
        switch sender.tag {
        case 0:
            calendar.current -= 1
        case 1:
            calendar.current += 1
        default:
            break
        }
        if viewModel.switchYear(int: calendar.current) {
            view().updateYear(year: calendar.year)
        }
        view().updateMonth(month: calendar.months[calendar.current].capitalized)
        viewModel.switchMonth(tag: sender.tag) {
            self.daysChanger()
            self.view().collectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let calendar = viewModel.calendarModel?.days else { return 0 }
        return calendar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.days = viewModel.cellViewModelCalendar(index: indexPath.row)
        guard let calendar = viewModel.calendarModel, let indent = calendar.indent else { return cell }
        return cell
    }

//    func checker(indexPath: Int) {
//        guard let calendar = viewModel.calendarModel, let indent = calendar.indent else { return }
//        if (0...indent).contains(indent) {
//
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tableViewTaskModel = []
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        UIView.transition(with: collectionView,
                          duration: 0.2,
                          options: [.curveEaseIn],
                          animations: {
                            cell.backgroundColor = .red
                            guard let indexView = self.viewModel.indexPath else { return }
                            collectionView.cellForItem(at: indexView)?.backgroundColor = .white
                            }
        ,completion: nil)
        guard let calendar = viewModel.calendarModel, let day = cell.days else { return }
        let date = "\(calendar.current + 1)/\(day)/\(calendar.year) 23:59".currentTimeInMiliseconds()
        let anotherDay = "\(calendar.current + 1)/\(day)/\(calendar.year) 00:00".currentTimeInMiliseconds()
        viewModel.addTaskToTableView(day: day, checker: (Double(anotherDay),Double(date)), completion: {
        DispatchQueue.main.async {
        self.view().tableView.reloadData()
        }
        })
        viewModel.indexPath = indexPath
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewTaskModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
        return cell
    }
    
    
}
