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
    
    func loadStudentsFromCoreData() {
        let persistenceManager = CoreDataPersistenceManager<Student>()
        students = persistenceManager.getObjectList()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studentFormDetail" {
            let controller = segue.destination as! StudentRegistrationDetailViewController
            if let student = sender as? StudentModel {
                controller.student = student
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
        cell.setupName(name: student.studentName ?? "Unknown")
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
