module beating_the_wooden_drum;

import std.stdio;
import std.conv: to;
import std.format;

import raylib;

import my_utils.my_tools;
import my_utils.raylibx.draw_unitext;


struct WindowView
{
    debug 
	{
		static immutable WIDTH = 900;
        static immutable HEIGHT = 500;
	} else{
	    static immutable WIDTH = 1920;
        static immutable HEIGHT = 1080;
	}

    debug
    {
        static immutable FPS = 56;
        static immutable DIS = 28;
    }
    else
    {
        static immutable FPS = 56;
        static immutable DIS = 28;
    }

    static immutable char* TITLE = "自动功德机";
}

void main_chinese()
{
	ConsoleCoding.toUTF8(true);

	InitWindow(WindowView.WIDTH, WindowView.HEIGHT, WindowView.TITLE);
	//ToggleFullscreen();
    SetWindowState(ConfigFlags.FLAG_WINDOW_RESIZABLE);


    InitAudioDevice();


	Image imgBackground = LoadImage("sources/pictures/woodenDrum.png");

	CTextDrawing dw;
    load_CTextDrawing(&dw, "佛", "C:/Windows/Fonts/simkai.ttf", 64);

    immutable int pngNum = 1800;
    SetTargetFPS(WindowView.FPS);
    SetMouseScale(1.0, 1.0);
    Sound msc = LoadSound("sources/sounds/BeatingTheWoodenDrum.wav");

    CTextDrawing keySpace_note_text;
    load_CTextDrawing(&keySpace_note_text, "按空格键敲击木鱼，\n增加你的功德！\n", "C:/Windows/Fonts/simkai.ttf", 32);

    CTextDrawing note_text;
    load_CTextDrawing(&note_text, "按 ← 键自动敲击木鱼，按 → 键手动敲击木鱼\n按 Esc 键退出程序\n", "C:/Windows/Fonts/simkai.ttf", 20);

    CTextDrawing mode_text_auto;
    load_CTextDrawing(&mode_text_auto, "自动模式", "C:/Windows/Fonts/simkai.ttf", 40);
    CTextDrawing mode_text_manu;
    load_CTextDrawing(&mode_text_manu, "手动模式", "C:/Windows/Fonts/simkai.ttf", 40);

    // DrawTextAnyCode merits_add_one_text = new DrawTextAnyCode;
    // merits_add_one_text.loading("功德 + 1！", "C:/Windows/Fonts/simkai.ttf", 32);

    CTextDrawing wan_sign_text;
    load_CTextDrawing(&wan_sign_text, "卍", "C:/Windows/Fonts/simhei.ttf", 120);

    ulong merits_total = 0; 
    bool is_automic_mode = false;

    CTextDrawing score_text;

    while (!WindowShouldClose()) {
		consoleClear();

		Texture tImgBackground = LoadTextureFromImage(imgBackground);
        string total_string = "功德: " ~ format("%s\0", merits_total);

		BeginDrawing();                                                   
        ClearBackground(Colors.BLANK);

        // 画背景图
        DrawTextureEx(tImgBackground, Vector2(250, 150), 0, 0.4, Colors.BROWN);

        // 空格提示
		draw_CTextDrawing(&keySpace_note_text, 50, 50, 10, Colors.RED);
        draw_CTextDrawing(&note_text, 50, 150, 10, Colors.GREEN);

        // 模式提示
		if(is_automic_mode) {
            draw_CTextDrawing(&mode_text_auto, 50, 250, 10, Colors.BLUE);
		} else {
			draw_CTextDrawing(&mode_text_manu, 50, 250, 10, Colors.BLUE);
		}

        // 分数
		load_CTextDrawing(&score_text, total_string.ptr, "C:/Windows/Fonts/simkai.ttf", 30);

		draw_CTextDrawing(&score_text, 600, 250, 10, Colors.ORANGE);

        clear_CTextDrawing(&score_text);

        keyboard_event(&msc, &is_automic_mode, &merits_total);
        // 佛字
        draw_CTextDrawing(&dw, 700, 350, 90, Colors.YELLOW);

        // 万字
        draw_CTextDrawing(&wan_sign_text, 750, 50, 90, Colors.GOLD);

        EndDrawing();
        UnloadTexture(tImgBackground);
	}  

	UnloadImage(imgBackground);
    UnloadSound(msc);
    CloseWindow();
    CloseAudioDevice();

    // 文字释放
    unload_CTextDrawing(&score_text);
    unload_CTextDrawing(&mode_text_manu);
    unload_CTextDrawing(&mode_text_auto);
    unload_CTextDrawing(&note_text);
    unload_CTextDrawing(&keySpace_note_text);
    unload_CTextDrawing(&wan_sign_text);
    unload_CTextDrawing(&dw);
    import core.stdc.stdlib;
    system("pause");
    ConsoleCoding.toGBK(true);
}

void keyboard_event(Sound * msc, bool* is_automic_mode, ulong* merits_total)
{
	if(*is_automic_mode == true) {
        ClearBackground(Colors.BLACK);
		mySleep(100);
		PlaySound(*msc);
		++*merits_total;
		mySleep(100); 
		// 功德 + 1
		DrawText("+ 1", 420, 230, 25, Colors.GOLD);
        mySleep(1000);
	} else {
		mySleep(100);
		if(IsKeyPressed(KeyboardKey.KEY_SPACE)) {
			PlaySound(*msc);
			mySleep(50);        
		}
		mySleep(100);
		if(IsKeyReleased(KeyboardKey.KEY_SPACE)) {
			StopSound(*msc); 
			++*merits_total;
			// 功德 + 1
			DrawText("+ 1", 420, 230, 25, Colors.GOLD);
		}
	}

	if(IsKeyPressed(KeyboardKey.KEY_LEFT)) {
		mySleep(100);
		*is_automic_mode = true;
		mySleep(100);
	}
	if(IsKeyPressed(KeyboardKey.KEY_RIGHT)) {
		mySleep(100);
		*is_automic_mode = false;
		mySleep(100);
	}
}

void main()
{
	main_chinese();
}