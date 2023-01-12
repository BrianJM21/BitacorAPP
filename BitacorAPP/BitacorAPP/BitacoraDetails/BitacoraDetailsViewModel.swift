//
//  BitacoraDetailsViewModel.swift
//  BitacorAPP
//
//  Created by Dragon on 12/01/23.
//
//  Mantained by Alan Badillo Salas
//
//  Changes:
//  * [12/01/23] Definition of BitacoraDetailsViewModel class
//  * [12/01/23] Add code (not tested)
//

import Foundation
import Combine

class BitacoraDetailsViewModel {
    
    // MODEL AND VIEW BINDING
    
    /// Model attached
    weak var model: BitacoraModel?
    
    /// View attached (associated view)
    weak var view: BitacoraDetailsView?
    
    // SUBSCRIBERS OF MODEL (WATCHERS/OBSERVABLES)
    
    /// Subscribe to the model `$bitacoraSelected` publisher
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    /// Subscribe to the model `$statusOfBitacoraSelected` publisher
    var statusOfBitacoraSelectedSubscriber: AnyCancellable?
    
    // INITIALIZER
    
    /// Initialize new View-Model with the attached model
    init(model: BitacoraModel) {
        self.subscribeToModel(model: model)
    }
    
    /// Listen changes from the model
    func subscribeToModel(model: BitacoraModel) {
        self.model = model
        
        // Subscribe to the current selected bitácora changes
        self.bitacoraSelectedSubscriber = model.$bitacoraSelected.dropFirst().sink {
            
            // WARNING: `self` is auto-captured by this clousure (needed)
            [weak self] bitacora in
            
            // TODO: Notify to view current selected bitácora was changed
            self?.refreshBitacoraSelected()
            
        }
        
        // Subscribe to the list of status of the current selected bitácora changes
        self.statusOfBitacoraSelectedSubscriber = model.$statusOfBitacoraSelected.dropFirst().sink {
            
            // WARNING: `self` is auto-captured by this clousure (needed)
            [weak self] statusOfBitacoraSelected in
            
            // TODO: Notify to view list of status of the current selected bitácora was changed
            self?.refreshStatusOfBitacoraSelected()
            
        }

    }
    
    /// Stop listen changes from the model
    func unsubscribeToModel() {
        
        // Unsubscribe model listeners
        self.bitacoraSelectedSubscriber?.cancel()
        self.bitacoraSelectedSubscriber = nil
        self.statusOfBitacoraSelectedSubscriber?.cancel()
        self.statusOfBitacoraSelectedSubscriber = nil
        
    }
    
    /// Release the model and view if necessary
    func dispose() {
        
        // Clean view and model
        self.model = nil
        self.view = nil
        
    }
    
    // OPERATIONS (FROM VIEW TO MODEL)
    
    /// Send the current selected bitácora to the view
    func refreshBitacoraSelected() {
        
        // Verify model exists (unwrap)
        guard let model = self.model else {
            // TODO: There are not model
            return
        }
        
        // Verify view exists (unwrap)
        guard let view = self.view else {
            // TODO: There are not view
            return
        }
        
        // The current selected bitácora in model is optional
        if let bitacora = model.bitacoraSelected {
            // TODO: Handle the current selected bitácora
            view.bitacora(bitacoraSelected: bitacora)
        } else {
            // TODO: There are not bitácora selected
        }
        
    }
    
    /// Send the list of status of the current selected bitácora to the view
    func refreshStatusOfBitacoraSelected() {
        
        // Verify model exists (unwrap)
        guard let model = self.model else {
            // TODO: There are not model
            return
        }
        
        // Verify view exists (unwrap)
        guard let view = self.view else {
            // TODO: There are not view
            return
        }
        
        // TODO: Handle the list of status of the current selected bitácora
        view.bitacora(statusOfBitacoraSelected: model.statusOfBitacoraSelected)
        
    }
    
}