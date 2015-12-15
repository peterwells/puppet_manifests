class aws-cli{
	exec {"get pip install":
		command =>	"wget https://bootstrap.pypa.io/get-pip.py",
		path =>		$exec_path,
		cwd =>		"/home/${user}",
		onlyif =>   "test ! -e /home/${user}/get-pip.py"
	}
	->
	exec {"install pip":
		command => "sudo python get-pip.py",
		path =>		$exec_path,
		cwd =>		"/home/${user}"
	}
	->
	exec {"install aws-cli":
		command => "sudo pip install awscli",
		path =>		$exec_path,
		cwd =>		"/home/${user}"
	}

}