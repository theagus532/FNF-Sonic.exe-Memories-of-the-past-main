package;

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


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class ExtrasState extends MusicBeatState // REWRITE FREEPLAY!?!?!? HELL YEA!!!!!
{

	public static var talk:FlxText;

	override function create()
	{
		talk = new FlxText();
		talk.text = "Hey so this isn't finished.\nI'm just here to prevent a softlock, sorry.";
		talk.alignment = CENTER;
		talk.scale.set(2.3,2.3);
		talk.updateHitbox();
		talk.screenCenter();
		add(talk);
		super.create();
	}
	

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if(controls.ACCEPT)
			MusicBeatState.switchState(new MainMenuState());
	}
}