using Godot;
using System;

public class apply : TextureButton
{
	private void _on_apply_pressed()
		{
			
		}
	private void _on_apply_mouse_entered()
	{
		GetNode<AnimationPlayer>("AnimationPlayer").Play("hover");
	}
	private void _on_apply_mouse_exited()
	{
		GetNode<AnimationPlayer>("AnimationPlayer").PlayBackwards("hover");
	}

	private void _gui_input(InputEventMouseButton e)
	{
		if (e is InputEventMouseButton)
		{
				if (e.Pressed == true)
				{
					Modulate = new Color(0.487793f, 0.487793f, 0.487793f);
				}
				else
				{
					Modulate = new Color(1, 1, 1);
				}
		}
	}
}








