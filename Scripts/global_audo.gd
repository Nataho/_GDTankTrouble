extends Node

@onready var sfx = {
	"bulletShoot" : "res://Assets/Audio/SFX/Sample_0000.wav",
	"bulletBounce": "res://Assets/Sample_0007.wav",
	"playerDie": "res://Assets/Sample_0002.mp3",
	"bulletCollide": "res://Assets/Sample_0004.wav",
	"whistle":"res://Assets/Audio/SFX/Sample_0028.wav",
	
	"button press": "res://Assets/Audio/SFX/Sample_0025.wav"
}

@onready var music = {
	"main menu": "res://Assets/Audio/Music/Stealthy Funktown Showdown.mp3",
	"game menu": "res://Assets/Audio/Music/GameMenu.mp3",
	"wii tanks 1": "res://Assets/Audio/Music/Wii Play Tanks Music  Brown Tank.mp3",
	"FFA 1": "res://Assets/Audio/Music/FFA 01 OST.mp3",
	
}

@onready var SFX: AudioStreamPlayer = $SFX
@onready var SFX2: AudioStreamPlayer = $SFX2
@onready var SFX3: AudioStreamPlayer = $SFX3
@onready var SFXEND: AudioStreamPlayer = $SFXEND


@onready var MUSIC = $Music
@onready var MUSIC2 = $Music2
@onready var MUSIC3 = $Music3

func STOP():
	SFX.stop()
	SFX2.stop()
	SFX3.stop()
	
	MUSIC.stop()
	MUSIC2.stop()
	MUSIC3.stop()

#region SFX
var pitchRange = Vector2(0.95,1.05)

func playSFX(sound:String,randPitch:bool):
	SFX.stream = load(sfx[sound])
	SFX.pitch_scale = 1
	if randPitch: SFX.pitch_scale = randf_range(pitchRange.x,pitchRange.y)
	SFX.play()
	#region SFX audios
	#bulletBounce
	#endregion

func playSFX2(sound,randPitch):
	SFX2.stream = load(sfx[sound])
	SFX2.pitch_scale = 1
	if randPitch: SFX2.pitch_scale = randf_range(pitchRange.x,pitchRange.y)
	SFX2.play()
	#region SFX2 audios
	#bulletCollide
	#bulletShoot
	#whistle
	#endregion

func playSFX3(sound,randPitch):
	SFX3.stream = load(sfx[sound])
	SFX3.pitch_scale = 1
	if randPitch: SFX3.pitch_scale = randf_range(pitchRange.x,pitchRange.y)
	SFX3.play()
	#region SFX audios
	#playerDie
	#endregion
	
func playSFXEND(sound,randPitch):
	SFXEND.stream = load(sfx[sound])
	SFXEND.pitch_scale = 1
	if randPitch: SFX3.pitch_scale = randf_range(pitchRange.x,pitchRange.y)
	SFXEND.play()
	#region SFX audios
	#playerDie
	#endregion
	
#endregion

#region music
func playMusic(sound):
	STOP()
	MUSIC.stream = load(music[sound])
	MUSIC.play()
#endregion
