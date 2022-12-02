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
using System.Windows.Controls;
using System.Windows.Media;
using Ost.PicoOsci.Ui.Core.WPF.MVVM;

namespace Ost.PicoOsci.Ui.Core.Window {
    /// <summary>
    /// A special window which supports custom operations
    /// </summary>
    [ExcludeFromCodeCoverage]
    public class RibbonWindow : Syncfusion.Windows.Tools.Controls.RibbonWindow, WindowIfc {
        /// <summary>
        /// Will set the binded <see cref="Control" />.
        /// <see cref="AutoBindingContext" /> for more information.
        /// </summary>
        public static readonly DependencyProperty AUTO_BINDING_CONTEXT_PROPERTY = DependencyProperty.Register("AutoBindingContext", typeof(object), typeof(RibbonWindow), new UIPropertyMetadata(null, OnAutoBindingContextPropertyChanged));

        /// <summary>
        /// Is a DataContext binding like WPF but it can be customized by the implementation.
        /// </summary>
        public object AutoBindingContext {
            get => GetValue(AUTO_BINDING_CONTEXT_PROPERTY);
            set => SetValue(AUTO_BINDING_CONTEXT_PROPERTY, value);
        }

        /// <inheritdoc cref="UserControlIfc.DataContext" />
        /// <summary>
        /// </summary>
        public new ViewModelIfc DataContext => base.DataContext as ViewModelIfc;

        /// <inheritdoc cref="WindowIfc.IsShutdown" />
        /// <summary>
        /// </summary>
        public bool IsShutdown { get; set; }

        /// <summary>
        /// Constructor.
        /// </summary>
        public RibbonWindow() {
            Loaded += OnLoaded;

            ShowHelpButton = false;
        }

        /// <inheritdoc cref="WindowIfc.SetOwner" />
        /// <summary>
        /// </summary>
        public void SetOwner(object owner) {
            Owner = (System.Windows.Window) owner;
        }

        /// <inheritdoc />
        public void BringToFront() {
            Activate();
        }

        /// <summary>
        /// Set automatic bindings where not defined in xaml.
        /// </summary>
        /// <param name="context"></param>
        protected virtual void SetAutoBindings(object context) {
            if (context is WindowViewModel viewModelBase) {
                if (viewModelBase.Control == null) {
                    viewModelBase.Control = this;
                    viewModelBase.OnViewLoaded();
                }

                base.DataContext = viewModelBase;
            }
        }

        private void OnLoaded(object sender, RoutedEventArgs e) {
            if (!m_loadedFirstTime) {
                if (!DesignerProperties.GetIsInDesignMode(this)) {
                    // subscribe to presentation source's ContentRendered event
                    PresentationSource presentationSource = PresentationSource.FromVisual((Visual) sender);
                    if (presentationSource != null) {
                        presentationSource.ContentRendered += OnContentRendered;
                    }
                }

                m_loadedFirstTime = true;
            }
        }

        private void OnContentRendered(object sender, EventArgs e) {
            // unsubscribe this event because we need the first call only
            ((PresentationSource) sender).ContentRendered -= OnContentRendered;

            DataContext?.OnContentRendered();
        }

        private static void OnAutoBindingContextPropertyChanged(DependencyObject element, DependencyPropertyChangedEventArgs e) {
            if (element is RibbonWindow control) {
                control.SetAutoBindings(control.AutoBindingContext);
            }
        }

        private bool m_loadedFirstTime;
    }
}
