//
//  ExtensionDelegate.swift
//  OctoPrintWatch Extension
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import WatchKit
import CommonCodeWatch

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.

                let statusStore = JobStatusStore()

                NetworkManager.shared.getJobProgress(success: { [weak self] (status) in
                    print(status)
                    statusStore.jobStatus = status
                    statusStore.hasError = false
                    self?.scheduleNextRefresh()
                    backgroundTask.setTaskCompletedWithSnapshot(false)
                }, failure: { [weak self] in
                    print("failure")
                    statusStore.jobStatus = nil
                    statusStore.hasError = false
                    self?.scheduleNextRefresh()
                    backgroundTask.setTaskCompletedWithSnapshot(false)
                })

            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

    private func scheduleNextRefresh() {
        /*WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date().addingTimeInterval(60) , userInfo: nil, scheduledCompletion: { (error: Error?) in
            if error == nil {
                print("background refresh scheduled")
            }
        })*/
    }

}
