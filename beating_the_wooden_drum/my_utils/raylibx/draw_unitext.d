module my_utils.raylibx.draw_unitext;

import raylib: LoadFileData, LoadFontFromMemory;
import raylib: Font, Colors, Vector2;
import raylib: DrawTextEx;
import raylib: UnloadFileData, UnloadFont;

static int* cstring_to_codepoints(scope const (char*) text, int* codePointCount)
{	
	assert(codePointCount != null);
	*codePointCount = 0;
	import std.conv: to;
	dstring s = to!dstring(text);
	int[] r = new int[s.length + 1];

	import std.range: stride;
	foreach (c; stride(s, 1)) {
		r[*codePointCount] = cast(int)(c);
		++*codePointCount;
	}
	r ~= 0;

	return r.ptr;
}

static pure int cstring_endwith(scope const(char*) src_string, scope const(char*) end_string)
{
	import std.conv: to;
	string src = to!string(src_string);
	string end = to!string(end_string);

	import std.string: endsWith;
	return endsWith(src, end);
}

static pure int cstring_iendwith(scope const(char*) src_string, scope const(char*) end_string)
{
	import std.conv: to;
	import std.uni: toLower;
	string src = toLower(to!string(src_string));
	string end = toLower(to!string(end_string));

	import std.string: endsWith;
	return endsWith(src, end);
}


struct CTextDrawing
{
	ubyte* __fontFileData;
	char* __text;
	Font __font;
	int* __codepoints;
	int __fontSize;
	bool __isClear;
}

void load_CTextDrawing(CTextDrawing* ctextdrawing, scope const(char*) text, scope const(char*) font_file, int fontSize)
{
	import core.stdc.string;
	int check_end = cstring_iendwith(font_file, ".ttf");
	if(check_end == 0){
		import std.stdio: writeln;
		throw new Exception("It is unsupported formated filename extension! Only `.ttf` Now!", __FILE__, __LINE__, null);
	}
	ctextdrawing.__isClear = false;
	uint fileSize;
	ctextdrawing.__text = cast(char*)text;
	ctextdrawing.__fontFileData = LoadFileData(font_file, &fileSize);
	int codepointsCount;

	ctextdrawing.__codepoints = cstring_to_codepoints(ctextdrawing.__text,&codepointsCount);
	ctextdrawing.__fontSize = fontSize;
	ctextdrawing.__font = LoadFontFromMemory(".ttf", ctextdrawing.__fontFileData, fileSize, ctextdrawing.__fontSize, ctextdrawing.__codepoints, codepointsCount);
}


void draw_CTextDrawing(CTextDrawing* ctextdrawing, int posX, int posY, float spacing, Colors color)
{
	DrawTextEx(ctextdrawing.__font, ctextdrawing.__text, Vector2(posX, posY), ctextdrawing.__fontSize, spacing, color);
}

void clear_CTextDrawing(CTextDrawing* ctextdrawing)
{
	import core.memory: GC;
	GC.free(GC.addrOf(cast(void*) ctextdrawing.__codepoints));	
	UnloadFileData(ctextdrawing.__fontFileData);
	ctextdrawing.__isClear = true;
}

void clear_once_CTextDrawing(CTextDrawing* ctextdrawing)
{
	if(!ctextdrawing.__isClear)
	{
		clear_CTextDrawing(ctextdrawing);
	}
}

void unload_CTextDrawing(CTextDrawing* ctextdrawing)
{
	//释放字体文件内容
	UnloadFont(ctextdrawing.__font);
	if(!ctextdrawing.__isClear) {
		clear_CTextDrawing(ctextdrawing);
	}
}