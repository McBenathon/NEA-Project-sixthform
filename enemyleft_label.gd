extends RichTextLabel

func _process(delta):
	self.text = str(ActorClass.enemies_num)
	 #this displays the variable enemies_num which decreases when enemies are killed
	if ActorClass.enemies_num == -1:
		$".".hide() #hides the enemies remaining when the boss is killed
