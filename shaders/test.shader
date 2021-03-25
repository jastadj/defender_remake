shader_type canvas_item;

void fragment() {
vec4 color = texture(TEXTURE,UV);
vec4 fragcoord = FRAGCOORD;

if(fragcoord.x >= 10.0 && fragcoord.x <= 30.0) color.a = 0.0;
else if(fragcoord.x >=35.0 && fragcoord.x <= 40.0) color.a = 0.0;
COLOR = color;
}