//
//  MemoryCalculationTableViewCell.swift
//  OTTApp
//
//  Created by  prasanth kumar on 29/09/21.
//

import UIKit

class MemoryCalculationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usedMemoryWidth: NSLayoutConstraint!
    @IBOutlet weak var appMemoryWidth: NSLayoutConstraint!
    @IBOutlet weak var freeMemoryWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("totalDiskSpace in bytes \(UIDevice.current.totalDiskSpaceInBytes)")
        print("usedDiskSpace in bytes \(UIDevice.current.usedDiskSpaceInBytes)")
        print("memory used by app: \(reportMemory())")
        
        let totalWidth = screenWidth - 40
        let fractionOfUsedMemory = CGFloat(UIDevice.current.usedDiskSpaceInBytes)/CGFloat(UIDevice.current.totalDiskSpaceInBytes)
        let appMemory = reportMemory()
        let fractionOfAppMemory = CGFloat(appMemory)/CGFloat(UIDevice.current.totalDiskSpaceInBytes)
        
        usedMemoryWidth.constant = totalWidth*fractionOfUsedMemory
        appMemoryWidth.constant = totalWidth*fractionOfAppMemory
    }

    func reportMemory() -> Float {
        var taskInfo = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        let usedMb = Float(taskInfo.phys_footprint) / 1048576.0
//        let totalMb = Float(ProcessInfo.processInfo.physicalMemory) / 1048576.0
        
//        result != KERN_SUCCESS ? print("Memory used: ? of \(totalMb)") : print("Memory used: \(usedMb) of \(totalMb)")
        
        return result != KERN_SUCCESS ? 0 : usedMb
    }
}
