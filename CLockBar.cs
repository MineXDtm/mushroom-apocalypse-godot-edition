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
	public string token;
	public string nickname;

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
	byte[] data = new byte[0];
	// Called when the node enters the scene tree for the first time.
	public void emotelistc(ProductUserId productuserid)
	{
		static T[] CombineTwoArrays<T>(T[] a1, T[] a2)
		{
			T[] arrayCombined = new T[a1.Length + a2.Length];
			System.Array.Copy(a1, 0, arrayCombined, 0, a1.Length);
			System.Array.Copy(a2, 0, arrayCombined, a1.Length, a2.Length);
			return arrayCombined;
		}
		var readFileOptions = new Epic.OnlineServices.TitleStorage.ReadFileOptions()
		{
			LocalUserId = productuserid,
			Filename = "emoteslist",
			ReadChunkLengthBytes = 1048576,
			ReadFileDataCallback = (Epic.OnlineServices.TitleStorage.ReadFileDataCallbackInfo readFileDataCallbackInfo) =>
			{
				data = CombineTwoArrays(data, readFileDataCallbackInfo.DataChunk);
				return Epic.OnlineServices.TitleStorage.ReadResult.RrContinuereading;
			},
			FileTransferProgressCallback = (Epic.OnlineServices.TitleStorage.FileTransferProgressCallbackInfo fileTransferProgressCallbackInfo) =>
			{
				var percentComplete = (double)fileTransferProgressCallbackInfo.BytesTransferred / (double)fileTransferProgressCallbackInfo.TotalFileSizeBytes * 100;
				GD.Print($"Downloading file <{fileTransferProgressCallbackInfo.Filename}> ({System.Math.Ceiling(percentComplete)}%)...");
			}
		};

		GD.Print($"Downloading file <{readFileOptions.Filename}> (creating buffer)...");

		var fileTransferRequest = platformInterface.GetTitleStorageInterface().ReadFile(readFileOptions, null, (Epic.OnlineServices.TitleStorage.ReadFileCallbackInfo readFileCallbackInfo) =>
		{

		GD.Print($"ReadFile {readFileCallbackInfo.ResultCode} - " + readFileCallbackInfo.Filename);

		if (readFileCallbackInfo.ResultCode == Result.Success)
		{
			GD.Print($"Successfully Downloaded emotelist {readFileCallbackInfo.Filename}");



			var jsonFile = JSON.Parse(data.GetStringFromUTF8()).Result;

			Dictionary ParsedData = jsonFile as Dictionary;
			var d = new Godot.Directory();
			d.Open("res://EmotesA");
			var files = new Godot.Collections.Array();
			d.ListDirBegin();
			IEnumerable<int> squares = Enumerable.Range(1, 99).Select(x => x * x);
			foreach (int num in squares)
			{
					var file1 = d.GetNext();

					if (file1 == "")
					{
						break;
					}
					else if (!file1.BeginsWith("."))
					{
						files.Add(file1);
					}
			}
			var pd = ParsedData["emotes"] as Godot.Collections.Array;
			
				
			}
		}
		);

		if (fileTransferRequest == null)
		{
			GD.Print("Error downloading file: bad handle");

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
	public void WriteFile()
	{
		var bytesWritten = 0;
		var openFileDialog = new OpenFileDialog();
		openFileDialog.InitialDirectory = "c:\\";
		openFileDialog.Filter = "PNG Portable Network Graphics (*.png)|*.png";

		openFileDialog.FilterIndex = 2;
		openFileDialog.RestoreDirectory = true;
		if (openFileDialog.ShowDialog() == DialogResult.OK)
		{
			GD.Print(ProductUserId.FromString(localuserid.ToString()));

			var writeFileOptions = new WriteFileOptions()
			{

				LocalUserId = productuserid,
				Filename = localuserid.ToString() + ".png",
				ChunkLengthBytes = 10485760,
				WriteFileDataCallback = (WriteFileDataCallbackInfo writeFileDataCallbackInfo, out byte[] buffer) =>
				{
					var fs = new FileStream($"{openFileDialog.FileName}", FileMode.Open, FileAccess.Read);

					if (fs.Length > bytesWritten)
					{

						var readBytes = new byte[System.Math.Min(writeFileDataCallbackInfo.DataBufferLengthBytes, fs.Length)];
						fs.Seek(bytesWritten, SeekOrigin.Begin);
						bytesWritten += fs.Read(readBytes, 0, (int)System.Math.Min(writeFileDataCallbackInfo.DataBufferLengthBytes, fs.Length));
						buffer = readBytes;
					}
					else
					{
						buffer = new byte[0];
						return WriteResult.CompleteRequest;
					}
					return WriteResult.ContinueWriting;
				},
				FileTransferProgressCallback = (FileTransferProgressCallbackInfo fileTransferProgressCallbackInfo) =>
				{
					var percentComplete = (double)fileTransferProgressCallbackInfo.BytesTransferred / (double)fileTransferProgressCallbackInfo.TotalFileSizeBytes * 100;
					GD.Print($"Downloading file <{fileTransferProgressCallbackInfo.Filename}> ({System.Math.Ceiling(percentComplete)}%)...");
				}
			};

			GD.Print($"Uploading file <{writeFileOptions.Filename}> (creating buffer)...");

			var fileTransferRequest = platformInterface
		.GetPlayerDataStorageInterface().WriteFile(writeFileOptions, null, (WriteFileCallbackInfo writeFileCallbackInfo) =>
		{
			GD.Print($"WriteFile {writeFileCallbackInfo.ResultCode}");

			if (writeFileCallbackInfo.ResultCode == Result.Success)
			{
				GD.Print($"Successfully uploaded {writeFileCallbackInfo.Filename}.");
				var im = new Image();
				im.Load(openFileDialog.FileName);
				GetNode("/root/SkinManager").Call("loadskin", im);
			}
			else
			{
				GD.Print($"Error uploading {writeFileCallbackInfo.Filename}: {writeFileCallbackInfo.ResultCode}.");
			}
		});

			if (fileTransferRequest == null)
			{
				GD.Print("Error uploading file: bad handle");
			}
		}
	}

	public void gethead(string id, string token, AtlasTexture t, int type)

	{
		var c = platformInterface.GetConnectInterface();
		if (type == 0)
		{



			var ap = new Epic.OnlineServices.Connect.LoginOptions()
			{
				Credentials = new Epic.OnlineServices.Connect.Credentials()
				{
					Type = ExternalCredentialType.Epic,
					Token = token,

				},
			};


			c.Login(ap, null, (Epic.OnlineServices.Connect.LoginCallbackInfo cl) =>
			{
				if (cl.ResultCode == Epic.OnlineServices.Result.Success)
				{


					GD.Print("chead succeeded");

					productuserid = cl.LocalUserId;

					var sk = new skinloader();
					sk.platformInterface = platformInterface;
					GD.Print(t);
					sk.ReadSkin(cl.LocalUserId, 0, EpicAccountId.FromString(id), t, GetNode("/root/SkinManager"));

				}
				else if (Epic.OnlineServices.Common.IsOperationComplete(cl.ResultCode))
				{
					GD.Print("chead failed: " + cl.GetResultCode());
				};
			}
				);
		}









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
						var sk = new skinloader();
						sk.platformInterface = platformInterface;

						sk.ReadSkin(productuserid, 1, localuserid, null, GetNode("/root/SkinManager"));
						
						
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
	public class skinloader
	{
		// Declare member variables here. Examples:
		// private int a = 2;
		// private string b = "text";
		public PlatformInterface platformInterface { get; set; }

		byte[] data = new byte[0];
		// Called when the node enters the scene tree for the first time.
		public void ReadSkin(ProductUserId productuserid, int type, EpicAccountId localuserid, AtlasTexture t, Node d)
		{
			static T[] CombineTwoArrays<T>(T[] a1, T[] a2)
			{
				T[] arrayCombined = new T[a1.Length + a2.Length];
				Array.Copy(a1, 0, arrayCombined, 0, a1.Length);
				Array.Copy(a2, 0, arrayCombined, a1.Length, a2.Length);
				return arrayCombined;
			}
			GD.Print(productuserid);
			GD.Print(localuserid);
			var readFileOptions = new ReadFileOptions()
			{
				LocalUserId = productuserid,
				Filename = localuserid.ToString() + ".png",
				ReadChunkLengthBytes = 1048576,
				ReadFileDataCallback = (ReadFileDataCallbackInfo readFileDataCallbackInfo) =>
				{
					data = CombineTwoArrays(data, readFileDataCallbackInfo.DataChunk);
					return ReadResult.ContinueReading;
				},
				FileTransferProgressCallback = (FileTransferProgressCallbackInfo fileTransferProgressCallbackInfo) =>
				{
					var percentComplete = (double)fileTransferProgressCallbackInfo.BytesTransferred / (double)fileTransferProgressCallbackInfo.TotalFileSizeBytes * 100;
					GD.Print($"Downloading file <{fileTransferProgressCallbackInfo.Filename}> ({System.Math.Ceiling(percentComplete)}%)...");
				}
			};

			GD.Print($"Downloading file <{readFileOptions.Filename}> (creating buffer)...");

			var fileTransferRequest = platformInterface.GetPlayerDataStorageInterface().ReadFile(readFileOptions, null, (ReadFileCallbackInfo readFileCallbackInfo) =>
			{

				GD.Print($"ReadFile {readFileCallbackInfo.ResultCode}");

				if (readFileCallbackInfo.ResultCode == Result.Success)
				{
					GD.Print($"Successfully setted {readFileCallbackInfo.Filename}");
					var im = new Image();
					//im.CreateFromData(32, 32, true, Image.Format.Rgb8, data);
					im.LoadPngFromBuffer(data);
					if (type == 1)
					{

						d.Call("loadskin", im);

					}
					if (type == 0)
					{
						var tt = new ImageTexture();

						tt.CreateFromImage(im, 0);
						t.Atlas = tt;
					}
				}
			}
			);

			if (fileTransferRequest == null)
			{
				GD.Print("Error downloading file: bad handle");

			}
		}
	}
	
}



	
