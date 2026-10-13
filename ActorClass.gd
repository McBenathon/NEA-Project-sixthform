extends CharacterBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

#all variables used in both player and enemy scripts

@export var playerhealth: = 100.0 #health varaible player
@export var enemyhealth: = 100.0 #health variable enemy
@export var damagerange: = 20 #damage range start. will change throughout game.
@export var enemy_damagerange: = 10
@export var damage: = 0
@export var kill_count: = 0
@export var upgrade_lvl: = 0
@export var speed: = Vector2(300.0,1000.0) 
@export var gravity: = 500.0
@export var move: = false
@export var heal: = false
var jump_max = 2 #variables used in double jump feature
var jump_count = 0
@export var enemies_num: = 0
@export var lvl2: = false
@export var boss: = false
@export var enemyposition: = Vector2(0,0)
