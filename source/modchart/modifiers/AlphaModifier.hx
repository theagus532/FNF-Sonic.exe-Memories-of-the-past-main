package modchart.modifiers;
import ui.*;
import modchart.*;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import math.*;

class AlphaModifier extends Modifier {
  public static var fadeDistY = 120;

  public function getHiddenSudden(player:Int=-1){
    return getSubmodPercent("hidden",player) * getSubmodPercent("sudden",player);
  }

  public function getHiddenEnd(player:Int=-1){
    return modMgr.state.center.y + fadeDistY * CoolUtil.scale(getHiddenSudden(player),0,1,-1,-1.25) + modMgr.state.center.y * getSubmodPercent("hiddenOffset",player);
  }

  public function getHiddenStart(player:Int=-1){
    return modMgr.state.center.y + fadeDistY * CoolUtil.scale(getHiddenSudden(player),0,1,0,-0.25) + modMgr.state.center.y * getSubmodPercent("hiddenOffset",player);
  }

  public function getSuddenEnd(player:Int=-1){
    return modMgr.state.center.y + fadeDistY * CoolUtil.scale(getHiddenSudden(player),0,1,1,1.25) + modMgr.state.center.y * getSubmodPercent("suddenOffset",player);
  }

  public function getSuddenStart(player:Int=-1){
    return modMgr.state.center.y + fadeDistY * CoolUtil.scale(getHiddenSudden(player),0,1,0,0.25) + modMgr.state.center.y * getSubmodPercent("suddenOffset",player);
  }

  function getAlpha(yPos:Float,player:Int,note:Note){
    var distFromCenter = yPos;
    var alpha:Float = 0;

    var time = Conductor.songPosition/1000;

    if(getSubmodPercent("hidden",player)!=0){
      var hiddenAdjust = CoolUtil.boundTo(CoolUtil.scale(yPos,getHiddenStart(player),getHiddenEnd(player),0,-1),-1,0);
      alpha += getSubmodPercent("hidden",player)*hiddenAdjust;
    }

    if(getSubmodPercent("sudden",player)!=0){
      var suddenAdjust = CoolUtil.boundTo(CoolUtil.scale(yPos,getSuddenStart(player),getSuddenEnd(player),0,-1),-1,0);
      alpha += getSubmodPercent("sudden",player)*suddenAdjust;
    }

    if(getPercent(player)!=0){
      alpha -= getPercent(player);
    }

    if(getSubmodPercent("blink",player)!=0){
      var f = CoolUtil.quantize(FlxMath.fastSin(time*10),0.3333);
      alpha += CoolUtil.scale(f,0,1,-1,0);
    }

    if(getSubmodPercent("randomVanish",player)!=0){
      var realFadeDist:Float = 240;
      alpha += CoolUtil.scale(Math.abs(distFromCenter),realFadeDist,2*realFadeDist,-1,0)*getSubmodPercent("randomVanish",player);
    }

    return CoolUtil.boundTo(alpha+1,0,1);
  }

  override function updateNote(note:Note, player:Int, pos:Vector3, scale:FlxPoint){
    var player = note.mustPress==true?0:1;
    var roundedSpeed = FlxMath.roundDecimal(PlayState.current.songSpeed, 2);
    var psuedoY:Float = (-((Conductor.songPosition - note.strumTime) * (0.45 * roundedSpeed)));

    var yPos:Float = psuedoY+modMgr.state.upscrollOffset;


    var alpha = getAlpha(yPos,player,note);
    var distFromHalf = Math.abs(alpha-0.5);
    var glow = CoolUtil.scale(distFromHalf,0,0.5,1.3,0);
    var alphaMod = 1 - getSubmodPercent("alpha",player) * (1-getSubmodPercent("noteAlpha",player));
    note.desiredAlpha = alpha * alphaMod;//((alpha>=0.5?1:0)*alphaMod);

    //note.effect.setFlash(glow);

  }

  override function updateReceptor(receptor:StrumNote, player:Int, pos:Vector3, scale:FlxPoint){
    var alpha = 1 - getSubmodPercent("alpha",player);
    if(getSubmodPercent("dark",player)!=0 || getSubmodPercent('dark${receptor.noteData}',player)!=0){
      alpha = alpha*(1-getSubmodPercent("dark",player))*(1-getSubmodPercent('dark${receptor.noteData}',player));
    }
    receptor.alpha = alpha;

  }

  override function update(elapsed:Float){

  }

  override function getSubmods(){
    var subMods:Array<String> = ["noteAlpha", "alpha", "hidden","hiddenOffset","sudden","suddenOffset","blink","randomVanish","dark"];
    return subMods;
  }
}
