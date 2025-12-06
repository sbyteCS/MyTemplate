using System.Runtime.InteropServices;
namespace script;
    static class Native
    {
    [DllImport("libheavyrender", CallingConvention = CallingConvention.Cdecl)]
    public static extern int main();
    }