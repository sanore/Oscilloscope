// MIT License
// 
// Copyright (c) 2021 LinearSPICE
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

using System;
using System.ComponentModel;
using System.Diagnostics.CodeAnalysis;
using System.Windows;
using System.Windows.Media;

namespace Ost.PicoOsci.Ui.Core.WPF.MVVM {
    /// <summary>
    /// Abstract base class for WPF user controls. Which uses a AutoBindingContext property that is useful
    /// when ViewModel must have life-cycle of control.
    /// </summary>
    [ExcludeFromCodeCoverage]
    public class UserControl : System.Windows.Controls.UserControl, UserControlIfc {
        /// <summary>
        /// Will set the binded <see cref="ViewModelBase.Control" />.
        /// <see cref="AutoBindingContext" /> for more information.
        /// </summary>
        // ReSharper disable once InconsistentNaming
        public static readonly DependencyProperty AutoBindingContextProperty =
            DependencyProperty.Register("AutoBindingContext", typeof(object), typeof(UserControl),
                                        new UIPropertyMetadata(null, OnAutoBindingContextPropertyChanged));

        /// <summary>
        /// Gets the ViewModelBase.
        /// </summary>
        public new ViewModelIfc DataContext => base.DataContext as ViewModelIfc;

        /// <summary>
        /// Is a DataContext binding like WPF but it can be customized by the implementation.
        /// </summary>
        public object AutoBindingContext {
            get => GetValue(AutoBindingContextProperty);
            set => SetValue(AutoBindingContextProperty, value);
        }

        /// <summary>
        /// Constructor.
        /// </summary>
        public UserControl() {
            Loaded += UserControlBase_Loaded;
        }

        /// <summary>
        /// Set automatic bindings where not defined in xaml.
        /// </summary>
        /// <param name="context"></param>
        protected virtual void SetAutoBindings(object context) {
            if (context is ViewModelBase viewModelBase) {
                if (viewModelBase.Control == null) {
                    viewModelBase.Control = this;
                    viewModelBase.OnViewLoaded();
                }

                base.DataContext = viewModelBase;
            }
        }

        private void UserControlBase_Loaded(object sender, RoutedEventArgs e) {
            if (!m_loadedFirstTime) {
                if (!DesignerProperties.GetIsInDesignMode(this)) {
                    // subscribe to presentation source's ContentRendered event
                    m_presentationSource = PresentationSource.FromVisual((Visual) sender);
                    if (m_presentationSource != null) {
                        m_presentationSource.ContentRendered += UserControlBase_ContentRendered;
                    }
                }

                m_loadedFirstTime = true;
            }
        }

        private void UserControlBase_ContentRendered(object sender, EventArgs e) {
            // unsubscribe this event because we need the first call only
            ((PresentationSource) sender).ContentRendered -= UserControlBase_ContentRendered;

            DataContext?.OnContentRendered();
        }

        private static void OnAutoBindingContextPropertyChanged(DependencyObject element,
                                                                DependencyPropertyChangedEventArgs e) {
            if (element is UserControl control) {
                control.SetAutoBindings(control.AutoBindingContext);
            }
        }

        private bool m_loadedFirstTime;
        private PresentationSource m_presentationSource;
    }
}
