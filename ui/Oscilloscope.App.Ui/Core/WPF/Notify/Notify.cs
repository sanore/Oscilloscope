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

namespace Oscilloscope.App.Ui.Core.WPF.Notify {
    /// <summary>
    /// Wrapper for the notify factory.
    /// </summary>
    public static class Notify {
        /// <summary>
        /// Creates a bool notifiable.
        /// </summary>
        /// <param name="defaultValue">The initial value</param>
        public static NotifyBoolIfc MakeBool(bool defaultValue) {
            return s_factory.Value.MakeBool(defaultValue);
        }

        /// <summary>
        /// Creates a reference notifiable.
        /// </summary>
        /// <param name="defaultValue">The initial value</param>
        public static NotifyRefIfc<T> MakeRef<T>(T defaultValue = null) where T : class {
            return s_factory.Value.MakeRef<T>(defaultValue);
        }

        /// <summary>
        /// Creates a reference delegate notifiable.
        /// </summary>
        /// <param name="notify">The notifiable to delegate to</param>
        public static NotifyRefIfc<T> MakeRefDelegate<T>(NotifyRefIfc notify) where T : class {
            return s_factory.Value.MakeRefDelegate<T>(notify);
        }

        /// <summary>
        /// Creates a string notifiable.
        /// </summary>
        /// <param name="defaultValue">The initial value</param>
        public static NotifyStringIfc MakeString(string defaultValue = "") {
            return s_factory.Value.MakeString(defaultValue);
        }

        /// <summary>
        /// Creates a value notifiable.
        /// </summary>
        /// <param name="defaultValue">The initial value</param>
        public static NotifyValIfc<T> MakeVal<T>(T defaultValue) where T : struct {
            return s_factory.Value.MakeVal<T>(defaultValue);
        }

        /// <summary>
        /// Creates a value delegate notifiable.
        /// </summary>
        /// <param name="notify">The notifiable to delegate to</param>
        public static NotifyValIfc<T> MakeValDelegate<T>(NotifyValIfc<T> notify) where T : struct {
            return s_factory.Value.MakeValDelegate<T>(notify);
        }

        /// <summary>
        /// Creates a nullable value notifiable.
        /// </summary>
        /// <param name="defaultValue">The initial value</param>
        public static NotifyValNullableIfc<T> MakeValNullable<T>(T? defaultValue) where T : struct {
            return s_factory.Value.MakeValNullable<T>(defaultValue);
        }

        /// <summary>
        /// Configure the wrapper with the used factory.
        /// </summary>
        /// <param name="factory"></param>
        public static void Configure(NotifyFactoryIfc factory) {
            s_factory = new Lazy<NotifyFactoryIfc>(() => factory);
        }

        /// <summary>
        /// Internal factory reference.
        /// </summary>
        private static Lazy<NotifyFactoryIfc> s_factory = new Lazy<NotifyFactoryIfc>(() => new NotifyFactory());
    }
}
