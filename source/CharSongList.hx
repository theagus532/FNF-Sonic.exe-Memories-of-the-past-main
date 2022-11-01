package;

class CharSongList
{
    public static var data:Map<String,Array<String>> = [
      "majin" => ["endless", "endless-og"],
      "lord x" => ["cycles"],
      "tails doll" => ["sunshine", "soulless"],
      "fleetway" => ["chaos"],
      "exe" => ["faker", "Black Sun", "Godspeed"],
      "fatalerror" => ["fatality"],
      "chaotix" => ["my-horizon", "our-horizon"],
      "educator" => ["playful"],
      "curse" => ["malediction"],
      "starved" => ["prey", "fight-or-flight"],
      "sl4sh" => ["b4cksl4sh"],
      "secret history tails" => ["mania"],
      "xterion" => ["substantial", "digitalized"],
      "needlemouse" => ["round-a-bout"],
      "hog" => ["hedge", "manual-blast"],
      "sunky" => ["milk"],
      "sanic" => ["too-fest"],
      "coldsteel" => ["personel"]
    ];

    public static var characters:Array<String> = [ // just for ordering
      "majin",
      "lord x",
      "tails doll",
      "fleetway",
      "exe",
      "fatalerror",
      "chaotix",
      "educator",
      "curse",
      "starved",
      "sl4sh",
      "secret history tails",
      "xterion",
      "satanos",
      "needlemouse",
      "hog",
      "sunky",
      "sanic",
      "coldsteel"
    ];

    // TODO: maybe a character display names map? for the top left in FreeplayState

    public static var songToChar:Map<String,String>=[];

    public static function init(){ // can PROBABLY use a macro for this? but i have no clue how they work so lmao
      // trust me I tried
      // if shubs or smth wants to give it a shot then go ahead
      // - neb
      songToChar.clear();
      for(character in data.keys()){
        var songs = data.get(character);
        for(song in songs)songToChar.set(song,character);
      }
    }

    public static function getSongsByChar(char:String)
    {
      if(data.exists(char))return data.get(char);
      return [];
    }

    public static function isLastSong(song:String)
    {
        /*for (i in songs)
        {
            if (i[i.length - 1] == song) return true;
        }
        return false;*/
      if(!songToChar.exists(song))return true;
      var songList = getSongsByChar(songToChar.get(song));
      return songList[songList.length-1]==song;
    }
}
