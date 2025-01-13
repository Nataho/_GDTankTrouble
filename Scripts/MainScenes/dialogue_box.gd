extends CanvasLayer
class_name DBOX
#var soundLib = SoundLib.characters

@onready var animate: AnimationPlayer = $Animate
signal dialogue_line_finished(index)
signal dialogue_finished
signal transition_finished

var charIndex = 0
var cps = 15 #characters per second

var playing:bool = false
var characterDefaults = {
	"full" : null,
	"left" : Vector2(14,14),
	"right" : Vector2(963,14),
}

var characters = {
	"Owen" : "res://Assets/Photos/Characters/owen.jpg",
	"Enric" : "res://Assets/Photos/Characters/enmyg.jpg",
	"Von": "res://Assets/Photos/Characters/Von.jpg",
	"Ric": "res://Assets/Photos/PowerUps/PowerUpMystery.png"
}

var text #temporary text variable
var dScript: Array #the entire script
var dScriptIndex = 0 #index of script or line number
var talking:String #the character currently talking
var talkingPlus #the character talking with it's properties

func _ready() -> void:
	cps = 10 / cps
	$Box.scale = Vector2(1,0)
	next()
	$Box/skip.grab_focus()
	GameManager.currentFocus = $Box/skip
	#animate.play("open")

#region signals
func DialogueLineFinished(index):
	playing = false
	
func DialogueFinished():
	StoryManager.isDialogue = false
	$Box/skip.release_focus()
	GameManager.currentFocus = null
	queue_free()
	print("signal Dialogue Finished Emmited")
#endregion signals

#region dialogue and sound
func output(dialogue:String):
	text = dialogue
	playing = true; StoryManager.isDialogue = true
	
	var textBuffer = ""
	if dialogue == null: dialogue = textBuffer #manage error
	if charIndex == 0: %Dialogue.text = textBuffer
	
	if charIndex < dialogue.length(): #checks length
		textBuffer += dialogue[charIndex] #add character to text
		%Dialogue.text += textBuffer #apply text
		charIndex += 1 #length
		
		await get_tree().create_timer(0.1*cps).timeout #0.1s timer
		output(dialogue) #reccursive function
	else: 
		charIndex = 0 #reset location
		emit_signal("dialogue_line_finished",dScriptIndex)
		#dialogue_line_finished.emit()

func playSound(character,emotion):
	if character not in characters: return
	if emotion not in talkingPlus[2]: return
	var Library = talkingPlus[3]
	var rng
	var sound
	if playing:
		rng = randi_range(0,Library[emotion]["start"].size()-1)
		sound = Library[emotion]["start"][rng]
	if !playing: 
		rng = randi_range(0,Library[emotion]["end"].size()-1)
		sound = Library[emotion]["end"][rng]
	$sfx.stream = load(sound)
	$sfx.play()
	if !playing: return
	if GameManager.Debug: print(playing)
	await $sfx.finished
	playSound(character,emotion)
#endregion dialogue and sound

#region proccess
func next():
	#manage error
	if dScriptIndex >= dScript.size():
		close()
		await animate.animation_finished
		dialogue_finished.emit()
		return
	
	var line = dScript[dScriptIndex]
	if talking != line[1][0]:
		if dScriptIndex != 0:
			close()
			await animate.animation_finished
		setLayout(line[1][1])
		%Dialogue.text = ""
		if line[1][0] in characters:
			%Character.show()
			%Character.texture = load(characters[line[1][0]])
		else: %Character.hide()
		open()
		await animate.animation_finished
	
	talking = line[1][0]
	talkingPlus = line[1]
	var text = talking + ": " + line[2]
	output(text)
	playSound(talking,line[0])
	dScriptIndex += 1
	#await dialogue_line_finished
	#await get_tree().create_timer(1).timeout

func skip():
	if transition: return
	if !playing: 
		next()
		return
		
	#print("skip")
	charIndex = 9999
	%Dialogue.text = text
	
	
	#var temp = cps
	#cps = 0.01
	#await get_tree().create_timer(1).timeout
	#cps = temp
#endregion proccess

#region getters
func isPlaying():
	return playing
#endregion getters

#region setters
func setDialogue(myScript:Array):
	dScript = myScript
	dScriptIndex = 0

func setLayout(layout:String):
	$shortcuts.play(layout)

func play():
	pass
func stop():
	pass
#endregion setters

#region OnOff
var transition = false
func open():
	transition = true
	animate.play("open")
	await animate.animation_finished
	transition = false
	transition_finished.emit()
	
func close():
	transition = true
	animate.play_backwards("open")
	await animate.animation_finished
	transition = false
	transition_finished.emit()
	$sfx.stop()
	
#endregion OnOff
