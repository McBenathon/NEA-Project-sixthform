extends RichTextLabel

func _process(delta):
	self.text = str(ActorClass.upgrade_lvl) #displays the variable upgrade_lvl in the label
