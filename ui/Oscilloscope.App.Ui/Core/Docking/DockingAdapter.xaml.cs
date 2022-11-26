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

using System.Collections;
using System.Collections.Specialized;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using Syncfusion.Windows.Tools.Controls;

namespace Ost.PicoOsci.Ui.Core.Docking {
    /// <summary>
    /// Interaction logic for DockingAdapter.xaml
    /// 
    /// An implementation for syncfusion DockingManager which supports MVVM pattern.
    /// <seealso cref="https://help.syncfusion.com/wpf/docking/pattern-and-practices#mvvm" />
    /// </summary>
    [ExcludeFromCodeCoverage]
    public partial class DockingAdapter {
        /// <summary>
        /// Dependency Property for <see cref="ActiveDocument" />
        /// </summary>
        public static readonly DependencyProperty ActiveDocumentProperty = DependencyProperty.Register(
            "ActiveDocument", typeof(PanelViewModelIfc), typeof(DockingAdapter), new PropertyMetadata(default(PanelViewModelIfc), OnActiveDocumentChanged));

        /// <summary>
        /// Dependency Property for <see cref="ItemsSource" />
        /// </summary>
        public static readonly DependencyProperty ItemsSourceProperty = DependencyProperty.Register(
            "ItemsSource", typeof(IList), typeof(DockingAdapter), new PropertyMetadata(default(IList)));

        /// <summary>
        /// Gets or sets the ItemsSource
        /// </summary>
        public IList ItemsSource {
            get => (IList) GetValue(ItemsSourceProperty);
            set => SetValue(ItemsSourceProperty, value);
        }

        /// <summary>
        /// Gets or sets the active document
        /// </summary>
        public PanelViewModelIfc ActiveDocument {
            get => (PanelViewModelIfc) GetValue(ActiveDocumentProperty);
            set => SetValue(ActiveDocumentProperty, value);
        }

        /// <summary>
        /// Adapter Constructor.
        /// </summary>
        public DockingAdapter() {
            InitializeComponent();

            PART_DockingManager.DockStateChanged += OnDockStateChanged;
            PART_DockingManager.Loaded += OnLoaded;
        }

        /// <inheritdoc />
        protected override void OnPropertyChanged(DependencyPropertyChangedEventArgs e) {
            switch (e.Property.Name) {
                case nameof(ItemsSource):
                    OnItemsSourceChanged(e);
                    break;
            }

            base.OnPropertyChanged(e);
        }

        private void OnLoaded(object sender, RoutedEventArgs e) {
            ((DocumentContainer) PART_DockingManager.DocContainer).AddTabDocumentAtLast = true;
        }

        private static void OnActiveDocumentChanged(DependencyObject sender, DependencyPropertyChangedEventArgs args) {
            if (!(sender is DockingAdapter adapter)) {
                return;
            }

            foreach (FrameworkElement element in adapter.PART_DockingManager.Children) {
                if (element is ContentControl control && control.Content == args.NewValue) {
                    adapter.PART_DockingManager.ActiveWindow = control;
                }
            }
        }

        private void OnDockingWindowChanged(DependencyObject d, DependencyPropertyChangedEventArgs e) {
            if (e.NewValue is ContentControl control) {
                if (((PanelViewModelIfc) control.Content).InitialState == DockState.Document) {
                    ActiveDocument = (PanelViewModelIfc) control.Content;
                }
            }
        }

        private void OnItemsSourceChanged(DependencyPropertyChangedEventArgs e) {
            if (e.OldValue != null && e.OldValue is INotifyCollectionChanged oldCollection) {
                oldCollection.CollectionChanged -= CollectionChanged;
            }

            if (e.NewValue != null && e.NewValue is INotifyCollectionChanged newCollection) {
                CreateAndAddPanel((IEnumerable) newCollection);

                newCollection.CollectionChanged += CollectionChanged;
            }
        }

        private void CreateAndAddPanel(IEnumerable elements) {
            BeginInit();

            var count = 0;
            foreach (var item in elements) {
                if (item is PanelViewModelIfc element) {
                    var control = new ContentControl {
                        Content = element,
                        DataContext = element
                    };

                    if (element.InitialState == DockState.Document) {
                        s_documentCounter++;

                        Syncfusion.Windows.Tools.Controls.DockingManager.SetHeader(control, $"{element.Header} #{s_documentCounter}");
                        Syncfusion.Windows.Tools.Controls.DockingManager.SetState(control, DockState.Document);
                    }
                    else {
                        if (count != 0) {
                            Syncfusion.Windows.Tools.Controls.DockingManager.SetTargetNameInDockedMode(control, $"item{count}");
                            Syncfusion.Windows.Tools.Controls.DockingManager.SetSideInDockedMode(control, element.InitialPosition);
                        }

                        Syncfusion.Windows.Tools.Controls.DockingManager.SetHeader(control, element.Header);
                        Syncfusion.Windows.Tools.Controls.DockingManager.SetDesiredWidthInDockedMode(control, 220);
                        Syncfusion.Windows.Tools.Controls.DockingManager.SetCanClose(control, false);
                        control.Name = $"item{count++}";
                    }

                    element.OnViewLoaded();
                    PART_DockingManager.Children.Add(control);
                    element.OnContentRendered();
                    element.OnUpdate();
                }
            }

            EndInit();
        }

        private void OnDockStateChanged(FrameworkElement sender, DockStateEventArgs e) {
            if (e.NewState == DockState.Hidden) {
                var viewModel = sender.DataContext as PanelViewModelIfc;

                sender.DataContext = null;
                viewModel?.Dispose();

                ItemsSource.Remove(viewModel);
            }
        }

        private void CollectionChanged(object sender, NotifyCollectionChangedEventArgs e) {
            if (e.Action == NotifyCollectionChangedAction.Reset) {
                PART_DockingManager.Children.Clear();
                PART_DockingManager.Children.ClearCollection();
            }

            if (e.OldItems != null) {
                foreach (var item in e.OldItems) {
                    var control = (from ContentControl element in PART_DockingManager.Children
                                   where element.Content == item
                                   select element).FirstOrDefault();
                    PART_DockingManager.Children.Remove(control);
                }
            }

            if (e.NewItems != null) {
                CreateAndAddPanel(e.NewItems);
            }
        }

        private static int s_documentCounter = 0;
    }
}
