//
//  StudentsRegistrationListViewController.swift
//  Poc_Solid
//
//  Created by Maria Tupich on 24/07/24.
//

import UIKit

class StudentsRegistrationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadStudentsFromCoreData()
        tableView.register(RegistrationListCell.self, forCellReuseIdentifier: "registerCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func loadStudentsFromCoreData() {
        let persistenceManager = CoreDataPersistenceManager<Student>()
        students = persistenceManager.getObjectList()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studentFormDetail" {
            let controller = segue.destination as! StudentRegistrationDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.student2 = students[indexPath.row]
            }
        }
    }
    
}

extension StudentsRegistrationListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RegistrationListCell = tableView.dequeueReusableCell(withIdentifier: "registerCell", for: indexPath) as! RegistrationListCell
        let student = students[indexPath.row]
        guard let studentName = student.studentName else { return UITableViewCell() }
        cell.setupName(name: studentName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = StudentModel(name: students[indexPath.row].studentName ?? "", gender: students[indexPath.row].studentGender ?? "", email: students[indexPath.row].studentEmail ?? "", Id: students[indexPath.row].studentId ?? "")
        self.performSegue(withIdentifier: "studentFormDetail", sender: student)
    }
}

struct StudentModel {
    let name: String
    let gender: String
    let email: String
    let Id: String
}
