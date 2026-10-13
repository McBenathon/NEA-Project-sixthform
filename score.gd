extends RichTextLabel

func _process(delta):
	self.text = str(ActorClass.kill_count) #displays the varialbe kill_count in the label
