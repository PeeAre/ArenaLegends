class_name  Transition

var from: State
var to: State
var predicate: Callable
	
func _init(from: State, to: State, predicate: Callable):
	self.from = from
	self.to = to
	self.predicate = predicate
