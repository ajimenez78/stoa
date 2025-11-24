class_name State extends Node

static var player: Player

## What happens when the player enters this state?
func enter() -> void:
	pass

## What happens when the player exits this state?
func exit() -> void:
	pass

func process(_delta: float) -> State:
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
