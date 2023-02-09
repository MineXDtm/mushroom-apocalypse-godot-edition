using Epic.OnlineServices;
using Epic.OnlineServices.Friends;
using Epic.OnlineServices.Platform;
using Epic.OnlineServices.PlayerDataStorage;
using Epic.OnlineServices.UserInfo;
using System.IO;
using System.Windows.Forms;
using Godot;
using Epic.OnlineServices.Connect;
using Epic.OnlineServices.Auth;
using System;
using Object = System.Object;
using Epic.OnlineServices.Presence;
using LoginCallbackInfo = Epic.OnlineServices.Auth.LoginCallbackInfo;
using Godot.Collections;
using Array = System.Array;
using Newtonsoft.Json;
using System.Linq;
using System.Collections.Generic;
using System.Net;
using System.IO.MemoryMappedFiles;
using System.Text;
public class CLockBar : Node
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	private static PlatformInterface platformInterface;
	private static FriendsInterface Friendsinterface;
	private static PlayerDataStorageInterface PlayerDataStorageInterface;
	private static EpicAccountId localuserid;
	private static EpicAccountId localuseridf;
	private static ProductUserId productuserid;
	public string nickname;
	public String CustomSkin = "null";
	public string token ;
	string nickp = "/root/menu/menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/Nickname";
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		string productName = "mushroom apocalypse";
		string productVersion = "0.0.5";
		string productId = "5ba931c4744445e19ca7a826bcc803e1";
		string sandboxId = "08f7e40eb8074134a6733e987be8857d";
		string deploymentId = "1fa029e4788a448eb8e85f379a8f8fc8";
		string clientId = "xyza7891LhaG2lVbex3pkzi0UbCLUKFV";
		string clientSecret = "SWByQFB0hkXwxlFgW7ildGxjXvqEE7DDYo+0ytEdLt0";



		var initializeOptions = new Epic.OnlineServices.Platform.InitializeOptions()
		{
			ProductName = productName,
			ProductVersion = productVersion
		};


		var initializeResult = Epic.OnlineServices.Platform.PlatformInterface.Initialize(initializeOptions);
		if (initializeResult != Epic.OnlineServices.Result.Success)
		{
			throw new System.Exception("Failed to initialize platform: " + initializeResult);
		}

		// The SDK outputs lots of information that is useful for debugging.
		// Make sure to set up the logging interface as early as possible: after initializing.
		Epic.OnlineServices.Logging.LoggingInterface.SetLogLevel(Epic.OnlineServices.Logging.LogCategory.AllCategories, Epic.OnlineServices.Logging.LogLevel.VeryVerbose);
		Epic.OnlineServices.Logging.LoggingInterface.SetCallback((Epic.OnlineServices.Logging.LogMessage logMessage) =>
		{
			System.Console.WriteLine(logMessage.Message);
		});

		var options = new Epic.OnlineServices.Platform.Options()
		{
			ProductId = productId,
			CacheDirectory = "C:/Users/andrey/AppData/Local/Temp",
			SandboxId = sandboxId,
			DeploymentId = deploymentId,
			EncryptionKey = "48404D635166546A576E5A7234753778214125442A472D4B614E645267556B58",
			ClientCredentials = new ClientCredentials()
			{
				ClientId = clientId,
				ClientSecret = clientSecret
			},
		};

		platformInterface = Epic.OnlineServices.Platform.PlatformInterface.Create(options);

		if (platformInterface == null)
		{
			GD.Print("Failed to create platform");
		}
		else
		{
			GetNode("/root/menu/accountmenu/bg/CenterContainer/box/CenterContainer/ScrollContainer/accauntsbox").Call("updatelist");

		}

	}
	
	

public void login()
	{
		var loginCredentialType = Epic.OnlineServices.Auth.LoginCredentialType.AccountPortal;
		/// These fields correspond to <see cref="Epic.OnlineServices.Auth.Credentials.Id" /> and <see cref="Epic.OnlineServices.Auth.Credentials.Token" />,
		/// and their use differs based on the login type. For more information, see <see cref="Epic.OnlineServices.Auth.Credentials" />
		/// and the Auth Interface documentation.
		string loginCredentialId = null;
		string loginCredentialToken = null;
		var authInterface = platformInterface.GetAuthInterface();
		if (authInterface == null)
		{
			GD.Print("Failed to get auth interface");
		}

		var loginOptions = new Epic.OnlineServices.Auth.LoginOptions()
		{
			Credentials = new Epic.OnlineServices.Auth.Credentials()
			{
				Type = loginCredentialType,
				Id = loginCredentialId,
				Token = loginCredentialToken
			}
		};


		// Ensure platform tick is called on an interval, or the following call will never callback.
		authInterface.Login(loginOptions, null, (Epic.OnlineServices.Auth.LoginCallbackInfo loginCallbackInfo) =>
		{
			if (loginCallbackInfo.ResultCode == Epic.OnlineServices.Result.Success)
			{
				log(loginCallbackInfo, authInterface);
			}
			else if (Epic.OnlineServices.Common.IsOperationComplete(loginCallbackInfo.ResultCode))
			{
				GD.Print("Login failed: " + loginCallbackInfo.ResultCode);
				if (loginCallbackInfo.ResultCode == Result.InvalidUser)
				{
					var cp = new CreateUserOptions();
					cp.ContinuanceToken = loginCallbackInfo.ContinuanceToken;
					var c = platformInterface.GetConnectInterface();
					c.CreateUser(cp, null, (CreateUserCallbackInfo data) =>
					{
						if (data.ResultCode == Epic.OnlineServices.Result.Success)
						{
							GetNode("/root/playerinfo").Call("create");
							log(loginCallbackInfo, authInterface);
						}
						else if (Epic.OnlineServices.Common.IsOperationComplete(data.ResultCode))
						{
							log(loginCallbackInfo, authInterface);
						}
					});
				}
			}
		}





		);
	}
	
	

	

	public void logaccaunt(string id, string token)
	{

		var loginCredentialType = Epic.OnlineServices.Auth.LoginCredentialType.PersistentAuth;
		/// These fields correspond to <see cref="Epic.OnlineServices.Auth.Credentials.Id" /> and <see cref="Epic.OnlineServices.Auth.Credentials.Token" />,
		/// and their use differs based on the login type. For more information, see <see cref="Epic.OnlineServices.Auth.Credentials" />
		/// and the Auth Interface documentation.
		string loginCredentialId = null;
		string loginCredentialToken = null;
		var authInterface = platformInterface.GetAuthInterface();
		if (authInterface == null)
		{
			GD.Print("Failed to get auth interface");
		}

		var loginOptions = new Epic.OnlineServices.Auth.LoginOptions()
		{
			Credentials = new Epic.OnlineServices.Auth.Credentials()
			{
				Type = loginCredentialType,
				Id = loginCredentialId,
				Token = loginCredentialToken
			}
		};

		// Ensure platform tick is called on an interval, or the following call will never callback.
		authInterface.Login(loginOptions, null, (Epic.OnlineServices.Auth.LoginCallbackInfo loginCallbackInfo) =>
		{
			if (loginCallbackInfo.ResultCode == Epic.OnlineServices.Result.Success)
			{

				log(loginCallbackInfo, authInterface);


			}
			else if (Epic.OnlineServices.Common.IsOperationComplete(loginCallbackInfo.ResultCode))
			{
				GD.Print("Login failed: " + loginCallbackInfo.ResultCode);
			}
		});

	}
	public Boolean logged()
	{

		if (localuserid != null)
		{
			return true;
		}
		return false;
	}
	public void log(LoginCallbackInfo loginCallbackInfo, AuthInterface authInterface)
	{
		localuserid = loginCallbackInfo.LocalUserId;

		GD.Print("Login succeeded " + loginCallbackInfo.LocalUserId);
		var s = platformInterface.GetUserInfoInterface();
		var sss = new QueryUserInfoOptions();
		sss.LocalUserId = loginCallbackInfo.LocalUserId;
		sss.TargetUserId = loginCallbackInfo.LocalUserId;

		s.QueryUserInfo(sss, null, (QueryUserInfoCallbackInfo g) =>
		{
			if (g.ResultCode == Epic.OnlineServices.Result.Success)
			{


				GD.Print("acc succeeded");
				
				var c = platformInterface.GetConnectInterface();
				var ap = new CopyUserAuthTokenOptions();

				var a = authInterface.CopyUserAuthToken(ap, loginCallbackInfo.LocalUserId, out var i);


				token = i.AccessToken;

				
				var loginOptions = new Epic.OnlineServices.Connect.LoginOptions()
				{
					Credentials = new Epic.OnlineServices.Connect.Credentials()
					{
						Type = ExternalCredentialType.Epic,
						Token = i.AccessToken,

					},
				};

				c.Login(loginOptions, null, (Epic.OnlineServices.Connect.LoginCallbackInfo cl) =>
				{
					if (cl.ResultCode == Epic.OnlineServices.Result.Success)
					{


						GD.Print("c succeeded");
						productuserid = cl.LocalUserId;

						Friendsinterface = platformInterface.GetFriendsInterface();


						setfriendlist();
					}
					else if (Epic.OnlineServices.Common.IsOperationComplete(cl.ResultCode))
					{
						GD.Print("c failed: " + cl.GetResultCode());
					};
				}
				);
				var copyUserInfoOptions = new CopyUserInfoOptions()
				{
					LocalUserId = g.LocalUserId,
					TargetUserId = g.LocalUserId
				};
				var result = s.CopyUserInfo(copyUserInfoOptions, out var userInfoData);

				if (userInfoData != null)
				{
					GD.Print("nickname: " + userInfoData.DisplayName);
				}
				else
				{

					return;
				}
				GetNode(nickp).Set("text", userInfoData.DisplayName);
				var ds = GetNode<Discord>("/root/discord_rpc");
				ds.nickname = userInfoData.DisplayName;
				ds.UpdatePresence();
				nickname = userInfoData.DisplayName;
				var al = GetNode("/root/menu/accountmenu/bg/CenterContainer/box/CenterContainer/ScrollContainer/accauntsbox");
				al.Call("save", localuserid.ToString(), userInfoData.DisplayName, token);

			}
			else if (Epic.OnlineServices.Common.IsOperationComplete(g.ResultCode))
			{
				GD.Print("acc failed: " + g.GetResultCode());
			};
		}
		  );


		GetNode("/root/menu/accountmenu").Set("visible", false);
	}
	public override void _Process(float delta)
	{
		if (platformInterface != null)
		{
			platformInterface.Tick();
		}
	}
	public void setfriendlist()
	{
		var s = platformInterface.GetUserInfoInterface();
		var d = new QueryFriendsOptions();
		d.LocalUserId = localuserid;
		Friendsinterface.QueryFriends(d, null, (QueryFriendsCallbackInfo e) =>
		{
			if (e.ResultCode == Epic.OnlineServices.Result.Success)
			{

				GD.Print("friends succeeded");
				GD.Print(platformInterface.GetPlayerDataStorageInterface());
				var flp = new GetFriendsCountOptions();
				flp.LocalUserId = e.LocalUserId;
				var fl = Friendsinterface.GetFriendsCount(flp);
				GD.Print(fl + " ");
				for (int i = 1; i == fl; i++)
				{
					var fp = new GetFriendAtIndexOptions();
					fp.Index = i - 1;
					fp.LocalUserId = localuserid;
					var fsp = new GetStatusOptions();

					

					var fid = Friendsinterface.GetFriendAtIndex(fp);

					var sss = new QueryUserInfoOptions();
					sss.LocalUserId = localuserid;
					sss.TargetUserId = fid;
					GD.Print(fid + " - " + i + " - " + localuserid);
					s.QueryUserInfo(sss, null, (QueryUserInfoCallbackInfo g) =>
					{
						if (g.ResultCode == Result.Success)
						{
							var copyUserInfoOptions = new CopyUserInfoOptions()
							{
								LocalUserId = localuserid,
								TargetUserId = fid

							};
							var result = s.CopyUserInfo(copyUserInfoOptions, out var userInfoData);

							if (userInfoData != null)
							{
								GD.Print("nickname: " + userInfoData.DisplayName);
								localuseridf = fid;
								GetNode("/root/FriendsSystem").Call("addfriend", userInfoData.DisplayName);
								var pr = platformInterface.GetPresenceInterface();

								var pp = new QueryPresenceOptions();
								pp.LocalUserId = localuserid;
								pp.TargetUserId = fid;
								pr.QueryPresence(pp, null, (QueryPresenceCallbackInfo q) =>
								{
									if (q.ResultCode == Result.Success)
									{
										var prp = new CopyPresenceOptions();
										prp.LocalUserId = localuserid;
										prp.TargetUserId = fid;
										var prc = pr.CopyPresence(prp, out var pri);

										GetNode("/root/FriendsSystem").Call("setstatus", i - 2, pri.Status.ToString().ToLower());
									}
									else if (Epic.OnlineServices.Common.IsOperationComplete(q.ResultCode))
									{
										GD.Print("QueryUserInfo failed: " + q.GetResultCode());
									}
								});




							}
							else
							{
								GD.Print("fail2");
							}

						}
						else if (Epic.OnlineServices.Common.IsOperationComplete(g.ResultCode))
						{
							GD.Print("QueryUserInfo failed: " + g.GetResultCode());
						}


					});
				}
			}
			else if (Epic.OnlineServices.Common.IsOperationComplete(e.ResultCode))
			{
				GD.Print("friends failed: " + e.GetResultCode());
			};


		});
	}
	void setsk(Image im)
	{
		GetNode("/root/SkinManager").Call("loadskin", im);
	}
	
	
	
	
}



	
