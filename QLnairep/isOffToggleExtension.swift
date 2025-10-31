//
//  isOffToggleExtension.swift
//  QLCodec Media Player
//
//  Created by Almahdi Morris Quet on 10/09/25.
//

import SwiftUI
import QuickLookUI


/// Adds '.isOff" to toggles so we can use the inverse of the binding
extension Toggle {
    init<V>(_ titleKey: LocalizedStringKey, isOff binding: Binding<V>) where Label == Text, V == Bool {
        self.init(titleKey, isOn: Binding(
            get: { !binding.wrappedValue },
            set: { binding.wrappedValue = !$0 }
        ))
    }
    
    init<S, V>(_ title: S, isOff binding: Binding<V>) where Label == Text, S : StringProtocol, V == Bool {
        self.init(title, isOn: Binding(
            get: { !binding.wrappedValue },
            set: { binding.wrappedValue = !$0 }
        ))
    }
}

