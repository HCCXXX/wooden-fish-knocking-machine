// $Id: $
/**
\file mytools.d
*/
/*
Copyright 2010 Austin Hastings. All rights reserved.

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but without any
warranty; without even the implied warranty of merchantability or fitness for a
particular purpose. see the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.
*/
module my_utils.my_tools;

class StringCast
{
public:
    @disable static char*string2mchars(string s, return out char[20] str)
    {
        if(str.length <= s.length) return str.ptr;
        int i = 0;
        for (; i < s.length; ++i)
        {
            str[i] = s[i];
        }
        str[i] = '\0';
        return str.ptr;
    }
	static T* mstring2mchars(T, size_t size = 0U, alias S = immutable(T)[] )(S s, return out T[size] str)
	in{
		assert(typeid(T) == typeid(char) || typeid(T) == typeid(wchar) || typeid(T) == typeid(dchar));
	}
	out(result){
		assert(result != null);
	}
	do{
		if(str.length <= s.length) return str.ptr;
		int i = 0;
		for (; i < s.length; ++i)	str[i] = s[i];
		if(typeid(T) == typeid(char))  str[i] = '\0';
		else if(typeid(T) == typeid(wchar))  str[i] = '\u0000';
		else if(typeid(T) == typeid(dchar))  str[i] = '\U00000000';
		return str.ptr;
	}
}

class ConsoleCoding
{
	version(Windows)
	{
	public:
		static void toUTF8(bool cls = false)
		{
			import core.stdc.stdlib: system;
			system("chcp 65001");
			cls?system("cls"):0;
		}

		static void toGBK(bool cls = false)
		{
			import core.stdc.stdlib: system;
			system("chcp 936");
			cls?system("cls"):0;
		}

		static void showCoding()
		{
			import core.stdc.stdlib: system;
			system("chcp");
		}

		static void showHelp()
		{
			import core.stdc.stdlib: system;
			system("chcp /?");
		}

		static void showChoices(bool stop = false)
		{
			import std.stdio: writeln;
			writeln("GBK(Simple Chinese):		936");
			writeln("Traditional Chinese:		950");
			writeln("UTF-8:				65001");
			writeln("US:				437");
			writeln("Multi-language(Latin I):	850");
			writeln("Slavic(Latin II):		852");
			writeln("Hilier(Russian):		855");
			writeln("Turkey:				857");
			writeln("Portuguese:			860");
			writeln("Icelandic:			861");
			writeln("Canadian-French:		863");
			writeln("German:				865");
			writeln("Russian:			866");
			writeln("Modern Greek:			869");
			writeln("");
			if(stop) {
				import std.stdio: readln;
				writeln("If you had known these, please press Enter to exit here.");
				readln();
			}
		}
	}
}



void mySleep(uint ms)
{
    version(Windows)
    {
        import core.sys.windows.winbase: Sleep;
        Sleep(ms);
    }

    version(linux)
    {
        import core.sys.linux.unistd: usleep;
        usleep(ms * 1000);
    }
}


void consoleClear()
{
	import core.stdc.stdlib: system;
	version(Windows)
    {
        system("cls");
    }

    version(linux)
    {
        system("clear");
    }

    version(OSX)
	{
        system("clear");
	}

    version(none)
	{
		throw new Exception("The command is not support in your system!\n", __FILE__, __LINE__, null);
	}

}

class NormalSingleton(T)
{
	private:
	static class NormalSingletonInner {
		private:
		   static __gshared NormalSingleton!(T) INSTANCE =  new NormalSingleton!(T)();
	}
	// 声明 静态无参构造器， 供   NormalSingletonInner 使用；声明为 private，外部无法使用
	static this(){}
	// 声明为 private，外部无法使用 无参构造器
	this() {}
	public:
	static NormalSingleton!(T) getInstance() {
		return NormalSingletonInner.INSTANCE;
	}
	static void show_id() {
		import std.stdio: writeln;
		writeln("id = ", &NormalSingletonInner.INSTANCE);
	}
}


unittest {
	class A: NormalSingleton!(int){
    public:
		static void print_id()
		{
			NormalSingleton!(int).show_id();
		}
		this(){
			super.getInstance();
		} 
	}
	A s1 = new A;
    A s2 = new A;
    A s3 = new A;

    s1.print_id();
    s2.print_id();
    s3.print_id();
}