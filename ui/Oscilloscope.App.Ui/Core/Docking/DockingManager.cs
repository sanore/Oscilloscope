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

using System.Collections.Generic;
using System.Collections.ObjectModel;
using DryIoc;
using Oscilloscope.App.Ui.Core.WPF.Notify;

namespace Oscilloscope.App.Ui.Core.Docking {
    /// <summary>
    /// A viewmodel for docking manager.
    /// </summary>
    public sealed class DockingManager : DockingManagerIfc {
        /// <inheritdoc />
        public ICollection<PanelViewModelIfc> Panels => m_panels;

        /// <inheritdoc />
        public NotifyRefIfc<PanelViewModelIfc> ActiveDocument { get; }

        /// <summary>
        /// Constructor.
        /// </summary>
        public DockingManager(IContainer application) {
            m_application = application;
            m_panels = new ObservableCollection<PanelViewModelIfc>();

            ActiveDocument = Notify.MakeRef<PanelViewModelIfc>();
        }

        /// <inheritdoc />
        public void Show<T>() where T : PanelViewModelIfc {
            var factory = m_application.Resolve<PanelFactoryIfc<T>>();
            var viewModel = factory.Create();
            if (!m_panels.Contains(viewModel)) {
                m_panels.Add(viewModel);
            }

            // auto focus on new document.
            if (viewModel is DocumentViewModel document) {
                ActiveDocument.Value = document;
            }
        }

        private readonly IContainer m_application;

        private readonly ObservableCollection<PanelViewModelIfc> m_panels;
    }
}
