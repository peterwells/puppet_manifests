class c_sharp{
	exec {"get mono gpg key to keyserver":
		command =>	"sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF",
		path =>		$exec_path
  	}
	->
	exec {"add mono repo to apt sources":
		command => 	"echo \"deb http://download.mono-project.com/repo/debian wheezy main\" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list",
		path 	=>	$exec_path
	}
	->
	exec {"add second mono repo to apt sources":
		command => 	"echo \"deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main\" | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list",
		path 	=>	$exec_path
	}
	->
	exec {"update apt to include mono":
		command	=>	"sudo apt-get update",
		path 	=>	$exec_path
	}

}