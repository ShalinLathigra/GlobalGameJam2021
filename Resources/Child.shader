shader_type canvas_item;

uniform vec3 input_color;
uniform bool gender;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	
	if (!gender){
		float rg_diff = COLOR.g - COLOR.r;
		float gb_diff = COLOR.g - COLOR.b;
		if (rg_diff > 0.05 && gb_diff > 0.1){
			COLOR = vec4(input_color, COLOR.w);
		}
	}else{
		float rb_diff = COLOR.b - COLOR.r;
		float gb_diff = COLOR.b - COLOR.g;
		if (gb_diff > 0.05 && rb_diff > 0.05){
			COLOR = vec4(input_color, COLOR.w);
		}
	}
}