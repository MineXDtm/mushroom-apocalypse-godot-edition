using Godot;
using System;

public class Button : Godot.Button
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}
	private void _on_Button_pressed()
	{
		var e = GetNode<CLockBar>("/root/epic");
		e.WriteFile();
	}
	//  // Called every frame. 'delta' is the elapsed time since the previous frame.
	//  public override void _Process(float delta)
	//  {
	//      
	//  }
}



