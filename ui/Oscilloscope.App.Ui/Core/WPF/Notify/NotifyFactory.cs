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

namespace Oscilloscope.App.Ui.Core.WPF.Notify {
    /// <see cref="NotifyFactoryIfc" />
    internal class NotifyFactory : NotifyFactoryIfc {
        /// <see cref="NotifyFactoryIfc.MakeBool" />
        public NotifyBoolIfc MakeBool(bool defaultValue) {
            return new NotifyBool(defaultValue);
        }

        /// <see cref="NotifyFactoryIfc.MakeRef" />
        public NotifyRefIfc<T> MakeRef<T>(T defaultValue) where T : class {
            return new NotifyRef<T>(defaultValue);
        }

        /// <see cref="NotifyFactoryIfc.MakeRefDelegate" />
        public NotifyRefIfc<T> MakeRefDelegate<T>(NotifyRefIfc notify) where T : class {
            return (NotifyRefIfc<T>) new NotifyRefDelegate<T>(notify);
        }

        /// <see cref="NotifyFactoryIfc.MakeString" />
        public NotifyStringIfc MakeString(string defaultValue) {
            return new NotifyString(defaultValue);
        }

        /// <see cref="NotifyFactoryIfc.MakeVal" />
        public NotifyValIfc<T> MakeVal<T>(T defaultValue) where T : struct {
            return new NotifyVal<T>(defaultValue);
        }

        /// <see cref="NotifyFactoryIfc.MakeValDelegate" />
        public NotifyValIfc<T> MakeValDelegate<T>(NotifyValIfc<T> notify) where T : struct {
            return (NotifyValIfc<T>) new NotifyValDelegate<T>(notify);
        }

        /// <see cref="NotifyFactoryIfc.MakeValNullable" />
        public NotifyValNullableIfc<T> MakeValNullable<T>(T? defaultValue) where T : struct {
            return new NotifyValNullable<T>(defaultValue);
        }
    }
}
