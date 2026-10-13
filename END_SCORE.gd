extends Label

func _process(delta):
	self.text = str(ActorClass.kill_count) #this displays the variable kill_count in the label
