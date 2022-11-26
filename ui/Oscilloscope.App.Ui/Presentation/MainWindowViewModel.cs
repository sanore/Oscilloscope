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
using Oscilloscope.App.Ui.Core.Actions;
using Oscilloscope.App.Ui.Core.Docking;
using Oscilloscope.App.Ui.Core.Window;
using Oscilloscope.App.Ui.Core.WPF.Notify;
using Oscilloscope.App.Ui.Oscilloscope;
using Oscilloscope.App.Ui.Oscilloscope.Actions;
using Oscilloscope.App.Ui.Presentation.RecordViewer;
using Oscilloscope.App.Ui.Presentation.TriggerCfg;
using Oscilloscope.App.Ui.Presentation.Update.Action;

namespace Oscilloscope.App.Ui.Presentation {
    /// <summary>
    /// The main window viewmodel
    /// </summary>
    public class MainWindowViewModel : WindowViewModel {
        /// <summary>
        /// Gets all panels
        /// </summary>
        public ICollection<PanelViewModelIfc> Panels => m_dockingManager.Panels;

        /// <summary>
        /// Gets or sets active document
        /// </summary>
        public NotifyRefIfc<PanelViewModelIfc> ActiveDocument => m_dockingManager.ActiveDocument;

        /// <summary>
        /// Gets a start command
        /// </summary>
        public AnActionIfc StartCommand => m_actionManager.GetAction(StartRecordAction.ID);

        /// <summary>
        /// Gets check for update command
        /// </summary>
        public AnActionIfc CheckForUpdate => m_actionManager.GetAction(CheckForUpdateAction.ID);

        /// <summary>
        /// Gets new chart diagram command
        /// </summary>
        public NotifyStringIfc StatusDescription => m_simulationManager.StatusDescription;

        public NotifyBoolIfc IsConnected => m_simulationManager.IsConnected;

        /// <summary>
        /// Constructor.
        /// </summary>
        public MainWindowViewModel(DockingManagerIfc dockingManager, OscilloscopeMgntIfc simulationManager, ActionManagerIfc actionManager) {
            m_dockingManager = dockingManager;
            m_simulationManager = simulationManager;
            m_actionManager = actionManager;
        }

        /// <inheritdoc />
        public override void OnViewLoaded() {
            base.OnViewLoaded();

            // open default panels
            m_dockingManager.Show<RecordViewerPanelViewModel>();
            m_dockingManager.Show<TriggerCfgPanelViewModel>();
        }

        private readonly DockingManagerIfc   m_dockingManager;
        private readonly OscilloscopeMgntIfc m_simulationManager;
        private readonly ActionManagerIfc    m_actionManager;
    }
}
