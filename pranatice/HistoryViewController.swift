//
//  HistoryViewController.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import UIKit
import CoreData

class HistoryViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext? = nil

    // MARK: - AlertSheet
    
    func editExercise(at indexPath: IndexPath) {
        let pranayama = self.fetchedResultsController.object(at: indexPath)
        let memoButtonString = pranayama.hasMemo ?
            NSLocalizedString("history.actionsheet.button.edit-memo", comment: "") :
            NSLocalizedString("history.actionsheet.button.add-memo", comment: "")
 
        // Set Up ActionSheet
        let optionMenu = UIAlertController(title: NSLocalizedString("history.actionsheet.main.title", comment: ""),
                                           message: "",
                                           preferredStyle: .actionSheet)
        // Buttons
        /*
        let editDateAction = UIAlertAction(title: NSLocalizedString("history.actionsheet.button.edit_date", comment: ""),
                                           style: .Default,
                                           handler: {
                                            alert in
                                            // DatePicker
                                            let controller = DatePickerViewController()
                                            controller.delegate = self
                                            controller.indexPath = indexPath
                                            controller.initialDate = pranayama.timeStamp
                                            controller.timeZone = pranayama.timeStampAt
                                            controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
                                            controller.modalTransitionStyle = .CrossDissolve
                                            self.presentViewController(controller, animated: false, completion: nil)
                                            
        })
        */
        let memoAction = UIAlertAction(title: memoButtonString,
                                       style: .default,
                                       handler: {
                                        alert in
                                        // open text input with indexpath
                                        self.modifyMemoAlertView(indexPath)
        })
        let deleteAction = UIAlertAction(title: NSLocalizedString("history.actionsheet.button.delete", comment: ""),
                                         style: .destructive,
                                         handler: {
                                            alert in
                                            let context = self.fetchedResultsController.managedObjectContext
                                            context.delete(self.fetchedResultsController.object(at: indexPath))
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("history.actionsheet.button.cancel", comment: ""),
                                         style: .cancel,
                                         handler: nil)
        
        // optionMenu.addAction(editDateAction)
        optionMenu.addAction(memoAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true, completion: nil)
    }
    
    func modifyMemoAlertView(_ indexPath: IndexPath) {
        var memoTextField: UITextField?
        let pranayama = self.fetchedResultsController.object(at: indexPath)
        let title = pranayama.hasMemo ?
            NSLocalizedString("history.memo-alert.title.edit", comment: "") :
            NSLocalizedString("history.memo-alert.title.add", comment: "")
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        let saveAction = UIAlertAction(title: NSLocalizedString("history.memo-alert.button.save", comment: ""),
                                       style: .default,
                                       handler: {
                                        alert in
                                        if !memoTextField!.text!.isEmpty {
                                            pranayama.memo = memoTextField!.text!
                                        }
                                        do {
                                            try pranayama.managedObjectContext?.save()
                                        } catch let error as NSError {
                                            print("Unresolved error \(error), \(error.userInfo)")
                                        }
                                        // self.tableView(self.tableView, cellForRowAt: indexPath)
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("history.memo-alert.button.cancel", comment: ""),
                                         style: .cancel,
                                         handler: {
                                            alert in
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.addTextField {
            (textField) -> Void in
            // Enter the textfiled customization code here.
            memoTextField = textField
            //            memoTextField!.becomeFirstResponder()
            if pranayama.hasMemo {
                memoTextField?.text = pranayama.memo
            } else {
                memoTextField?.placeholder = NSLocalizedString("history.memo-alert.placeholder.memo", comment: "")
            }
        }
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext

        self.title = NSLocalizedString("history.title", comment: "")
        tableView.rowHeight = 31.0
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: nil)
    }
    
    // MARK: - TableViewCell
    
    func configureCell(_ cell: UITableViewCell, withEvent event: Exercise) {
        let cell = cell as! HistoryViewCell
        let pranayama = event
        
        cell.mood = Int(pranayama.mood)
        cell.dateLabel.attributedText = String.formatForDateCell(string: pranayama.date(),
                                                                 weekcolor: UIColor.dayColor(date: pranayama.timeStamp! as Date),
                                                                 isAm: pranayama.isAM)
        cell.practiceLabel.text = pranayama.detail()
        // Memo
        cell.hasMemo = pranayama.hasMemo
        if pranayama.hasMemo {
            cell.memoLabel.text = pranayama.memo
        }
    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 31
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryViewCell", for: indexPath)
        let event = self.fetchedResultsController.object(at: indexPath)
        self.configureCell(cell, withEvent: event)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.delete(self.fetchedResultsController.object(at: indexPath))
            
            do {
                try context.save()
            } catch {
                 let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editExercise(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<Exercise> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: managedObjectContext!,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: "History")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<Exercise>? = nil
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Exercise)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

}
