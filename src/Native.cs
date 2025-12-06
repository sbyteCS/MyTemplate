using System;
using System.Runtime.InteropServices;

class Native
{
    [DllImport("libheavyrender", CallingConvention = CallingConvention.Cdecl)]
    public static extern int main();
}