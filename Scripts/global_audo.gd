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
	"square roll": "res://Assets/Audio/Music/The Roll of Squares.mp3",
}

var characters = {
	"Oshiro" = {
		"normal": {
			"start": [
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_01.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_02.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_03.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_04.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_05.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_06.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_07.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_08.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_09.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_A_10.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_01.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_02.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_03.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_04.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_05.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_06.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_07.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_08.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_09.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_B_10.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_01.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_02.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_03.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_04.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_05.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_06.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_07.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_08.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_09.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_mid_C_10.wav",
			],
			"end": [
				"res://Assets/Audio/Characters/Oshiro/normal_end_01.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_02.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_03.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_04.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_05.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_06.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_07.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_08.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_09.wav",
				"res://Assets/Audio/Characters/Oshiro/normal_end_10.wav",
			]
		},
		"happy": {
			"start":[
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_A_10.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_B_10.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_mid_C_10.wav",
			],
			"end": [
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidehappy_end_10.wav",
			]
		},
		"worried": {
			"start": [
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_01.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_02.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_03.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_04.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_05.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_06.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_07.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_08.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_09.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_A_10.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_01.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_02.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_03.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_04.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_05.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_06.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_07.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_08.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_09.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_B_10.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_01.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_02.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_03.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_04.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_05.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_06.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_07.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_08.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_09.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_mid_C_10.wav",
			],
			"end": [
				"res://Assets/Audio/Characters/Oshiro/worried_end_01.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_02.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_03.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_04.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_05.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_06.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_07.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_08.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_09.wav",
				"res://Assets/Audio/Characters/Oshiro/worried_end_10.wav",
			]
		},
		"suspicious": {
			"start": [
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_A_10.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_B_10.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_mid_C_10.wav",
			],
			"end": [
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_01.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_02.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_03.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_04.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_05.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_06.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_07.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_08.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_09.wav",
				"res://Assets/Audio/Characters/Oshiro/sidesuspicious_end_10.wav",
			]
		}
	},
	"Theo" = {
		"excited": {
			"start": [
				"res://Assets/Audio/Characters/Theo/excited_mid_A_01.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_02.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_03.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_04.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_05.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_06.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_07.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_08.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_09.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_A_10.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_01.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_02.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_03.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_04.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_05.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_06.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_07.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_08.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_09.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_B_10.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_01.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_02.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_03.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_04.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_05.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_06.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_07.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_08.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_09.wav",
				"res://Assets/Audio/Characters/Theo/excited_mid_C_10.wav",
			],
			"end": [
				"res://Assets/Audio/Characters/Theo/excited_per_01.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_02.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_03.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_04.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_05.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_06.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_07.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_08.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_09.wav",
				"res://Assets/Audio/Characters/Theo/excited_per_10.wav",
			]
		},
		"normal": {
			"start": [
				"res://Assets/Audio/Characters/Theo/normal_mid_A_01.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_02.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_03.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_04.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_05.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_06.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_07.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_08.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_09.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_A_10.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_01.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_02.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_03.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_04.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_05.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_06.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_07.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_08.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_09.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_B_10.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_01.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_02.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_03.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_04.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_05.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_06.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_07.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_08.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_09.wav",
				"res://Assets/Audio/Characters/Theo/normal_mid_C_10.wav",
			],
			"end": [
				"res://Assets/Audio/Characters/Theo/normal_per_01.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_02.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_03.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_04.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_05.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_06.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_07.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_08.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_09.wav",
				"res://Assets/Audio/Characters/Theo/normal_per_10.wav",
			]
		},
	}
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
	#STOP()
	if MUSIC.stream == load(music[sound]):return
	MUSIC.stream = load(music[sound])
	MUSIC.play()
#endregion
