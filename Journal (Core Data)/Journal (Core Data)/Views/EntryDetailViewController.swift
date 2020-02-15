//
//  EntryDetailViewController.swift
//  Journal (Core Data)
//
//  Created by Kevin Stewart on 2/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    // MARK: - Outlets
    @IBOutlet var moodControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlets
    
    @IBOutlet var entryTextField: UITextField!
    @IBOutlet var entryTextView: UITextView!
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = entryTextField.text,
            !title.isEmpty else { return }
        let bodyText = entryTextView.text
        let moodIndex = moodControl.selectedSegmentIndex
        let mood = MoodSwing.allMoods[moodIndex]
        
        if let entry = entry {
            entry.title = title
            entry.bodyText = bodyText
            entry.mood = mood.rawValue
        } else {
            Entry(title: title, bodyText: bodyText!, mood: mood)
        }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error saving entry: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        
        title = entry?.title ?? "Create Entry"
        entryTextField.text = entry?.title
        entryTextView.text = entry?.bodyText
        
        let mood: MoodSwing
        if let moodSwing = entry?.mood {
            mood = MoodSwing(rawValue: moodSwing)!
        } else {
            mood = .😐
        }
        
        moodControl.selectedSegmentIndex = MoodSwing.allMoods.firstIndex(of: mood) ?? 1
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
