package;

import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxTimer;
import flixel.input.gamepad.FlxGamepad;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import openfl.Lib;



#if windows
import Discord.DiscordClient;
#end

using StringTools;

class EncoreState extends MusicBeatState // REWRITE FREEPLAY!?!?!? HELL YEA!!!!!
{
	var whiteshit:FlxSprite;

	var curSelected:Int = 0;

	var songArray:Array<String> = ["too-slow-encore", 'you-cant-run-encore', "triple-trouble-encore", "endless-encore", "cycles-encore" ,"sunshine-encore"];

	var boxgrp:FlxTypedSpriteGroup<FlxSprite>;

	// menu shit.
	var bg:FlxBackdrop;
	var spikes:FlxBackdrop;

	var cdman:Bool = true;

	var fuck:Int = 0;

	var songtext:FlxText;
	var prevsongtext:FlxText;

	override function create()
	{
		whiteshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
		whiteshit.alpha = 0;

		bg = new FlxBackdrop(Paths.image('backgroundlool'), 0, 0, true, false);
		bg.screenCenter(X);
		bg.setGraphicSize(1280, 720);
		add(bg);
				
		bg.offset.x -= 0;
		bg.offset.y += 0;
		bg.velocity.x = 20;

		spikes = new FlxBackdrop(Paths.image('SPIKES2'), 0, 0, true, false);
		spikes.screenCenter(X);
		spikes.setGraphicSize(1280, 720);
		add(spikes);
				
		spikes.offset.x -= 0;
		spikes.offset.y += 0;
		spikes.velocity.x = 20;

		boxgrp = new FlxTypedSpriteGroup<FlxSprite>();

		songtext = new FlxText(0, FlxG.height - 100, songArray[curSelected], 25);
		songtext.setFormat("Sonic CD Menu Font Regular", 25, FlxColor.fromRGB(255, 255, 255));
		songtext.x = (FlxG.width / 2) - (25 / 2 * songArray[curSelected].length);
		add(songtext);

		FlxG.log.add('sexo: ' + (songtext.width / songArray[curSelected].length));

		prevsongtext = new FlxText(0, FlxG.height - 100, songArray[curSelected], 25);
		prevsongtext.x = (FlxG.width / 2) - (25 / 2 * songArray[curSelected].length);
		prevsongtext.setFormat("Sonic CD Menu Font Regular", 25, FlxColor.fromRGB(255, 255, 255));
		
		add(prevsongtext);

			for (i in 0...songArray.length)
			{

			
					FlxG.log.add(songArray[i] + ' found');
	
					var box:FlxSprite = new FlxSprite(fuck * 780, 0).loadGraphic(Paths.image('FreeBox'));
					boxgrp.add(box);

					var char:FlxSprite = new FlxSprite(fuck * 780, 0).loadGraphic(Paths.image('fpstuff/' + songArray[fuck].toLowerCase()));
					boxgrp.add(char);

					var daStatic:FlxSprite = new FlxSprite();		
					daStatic.frames = Paths.getSparrowAtlas('daSTAT');	
					daStatic.alpha = 0.2;	
					daStatic.setGraphicSize(620, 465);			
					daStatic.setPosition((fuck * 780) + 440, 211);	
					daStatic.animation.addByPrefix('static','staticFLASH', 24, true);			
					boxgrp.add(daStatic);
					daStatic.animation.play('static');

					fuck += 1;
				
			}

		
		add(boxgrp);

		 Lib.application.window.title = "Vs Sonic.exe' Memories Of The Past - Encore Menu";
		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Encore Menu", null);
		 #end

		add(whiteshit);

		super.create();
	}



	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A;
		var downP = FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D;
		var accepted = controls.ACCEPT;
		
		
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.DPAD_UP)
			{
				changeSelection(-1);
			}
			if (gamepad.justPressed.DPAD_DOWN)
			{
				changeSelection(1);
			}
		}

		if (cdman)
		{
			if (upP)
			{
				changeSelection(-1);
			}
			if (downP)
			{
				changeSelection(1);
			}
		}
		

		
		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}
		
		
		if (accepted && cdman && songArray[0] != 'lol')
		{
			cdman = false;

			switch (songArray[curSelected]) // Some charts don't include -hard in their file name so i decided to get focken lazy.
			{
				case "milk":
					PlayState.SONG = Song.loadFromJson('milk', 'milk');
				case "sunshine":
					PlayState.SONG = Song.loadFromJson('sunshine', 'sunshine');
				default:
					PlayState.SONG = Song.loadFromJson(songArray[curSelected].toLowerCase(), songArray[curSelected].toLowerCase());
			}

			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;
			PlayState.storyWeek = 1;
			FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			PlayStateChangeables.nocheese = false;
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}
		
	}

	
	function changeSelection(change:Int = 0)
	{

		#if !switch
		// NGio.logEvent('Fresh');
		#end
	
		if (change == 1 && curSelected != songArray.length - 1) 
		{
			cdman = false;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			FlxTween.tween(boxgrp ,{x: boxgrp.x - 780}, 0.2, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween)
				{
					cdman = true;
				}
			});
			
		}
		else if (change == -1 && curSelected != 0) 
		{
			cdman = false;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			FlxTween.tween(boxgrp ,{x: boxgrp.x + 780}, 0.2, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween)
				{
					cdman = true;
				}
			});

		}
		if ((change == 1 && curSelected != songArray.length - 1) || (change == -1 && curSelected > 0)) // This is a.
		{
			songtext.alpha = 0;
			songtext.text = songArray[curSelected + change];
			if (songArray[curSelected + change] == 'black-sun') songtext.text = 'black sun';
			FlxTween.tween(songtext ,{alpha: 1, x: (FlxG.width / 2) - (25 / 2 * songArray[curSelected + change].length)}, 0.2, {ease: FlxEase.expoOut});
			FlxTween.tween(prevsongtext ,{alpha: 0, x: (FlxG.width / 2) - (25 / 2 * songArray[curSelected + change].length)}, 0.2, {ease: FlxEase.expoOut});
		}

		curSelected += change;
		if (curSelected < 0) curSelected = 0;
		else if (curSelected > songArray.length - 1) curSelected = songArray.length - 1;
		
		// NGio.logEvent('Fresh');
		

	 	
	}
	
}

class EncoreMetadata //done to make the compiler shut up
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}