// MIT License
// 
// Copyright (c) 2021 Oscilloscope
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace Ost.PicoOsci.Ui.Core.WPF.Decorators {
    /// <summary>
    /// Abstract base class for observable objects.
    /// </summary>
    public abstract class ObservableObject : DisposableObject, ObservableObjectIfc, INotifyPropertyChanged {
        /// <inheritdoc cref="INotifyPropertyChanged.PropertyChanged" />
        public event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Constructor.
        /// </summary>
        public ObservableObject() {
            propertyChangedHandlers = new Dictionary<string, PropertyChangedEventHandler>();
        }

        /// <summary>
        /// register a property changed handler on this observable object ensuring it is registered only once
        /// with the uniqueHandlerId.
        /// </summary>
        /// <param name="uniqueHandlerId">a unique name, for which only one instance should be registered</param>
        /// <param name="handler">the PropertyChangedEventHandler delegate implementation</param>
        /// <returns>true if the handler has been registered, false if a handler with the uniqueHandlerId is already present</returns>
        public bool RegisterPropertyChangeHandler(string uniqueHandlerId, PropertyChangedEventHandler handler) {
            if (!propertyChangedHandlers.ContainsKey(uniqueHandlerId)) {
                PropertyChanged += handler;
                propertyChangedHandlers.Add(uniqueHandlerId, handler);
                return true;
            }

            return false;
        }

        /// <summary>Updates the property and raises the changed event, but only if the new value does not equal the old value. </summary>
        /// <param name="propertyName">The property name as lambda. </param>
        /// <param name="oldValue">A reference to the backing field of the property. </param>
        /// <param name="newValue">The new value. </param>
        /// <returns>True if the property has changed. </returns>
        protected bool Set<T>(ref T oldValue, T newValue, [CallerMemberName] string propertyName = null) {
            return Set(propertyName, ref oldValue, newValue);
        }

        /// <summary>Updates the property and raises the changed event, but only if the new value does not equal the old value. </summary>
        /// <param name="propertyName">The property name as lambda. </param>
        /// <param name="oldValue">A reference to the backing field of the property. </param>
        /// <param name="newValue">The new value. </param>
        /// <returns>True if the property has changed. </returns>
        protected bool Set<T>(string propertyName, ref T oldValue, T newValue) {
            if (Equals(oldValue, newValue)) {
                return false;
            }

            oldValue = newValue;
            OnPropertyChanged(propertyName);

            return true;
        }

        /// <summary>
        /// Frees any managed resources, your derived class has to override this in case:
        /// - the class manages any IDisposable objects
        /// - the class adds any event handlers
        /// - need to set references to to null to facilitate memory leak analysis via memory snapshot reference counts.
        /// Here, any event that has been registered through RegisterPropertyChangeHandler will be released.
        /// </summary>
        protected override void DisposeManaged() {
            foreach (var kp in propertyChangedHandlers) {
                PropertyChanged -= kp.Value;
            }

            propertyChangedHandlers.Clear();
        }

        /// <summary>
        /// Fires the <see cref="PropertyChanged" /> event for a given property.
        /// </summary>
        /// <param name="propertyName">The changed property.</param>
        protected void OnPropertyChanged(string propertyName = "") {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private readonly IDictionary<string, PropertyChangedEventHandler> propertyChangedHandlers;
    }
}
