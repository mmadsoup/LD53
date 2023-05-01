shader_type canvas_item;

void vertex() 
{
	VERTEX += vec2(cos(TIME), sin(TIME * 20.0) * 0.5);
}