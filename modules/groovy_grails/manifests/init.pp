class groovy_grails{
	#be sure JDK is installed
	exec{"install default JDK":
		command => "sudo apt-get install -y default-jdk",
		path	=> $exec_path
	}
	->
	file {"/home/${user}/.bashrc": 
      ensure => present
  	}
  	->
  	exec{"add grails_opt to env":
		command	=> "echo \"export GRAILS_OPTS=\"-XX:MaxPermSize=2048m -Xmx2048m -server\"\" >> /home/${user}/.bashrc",
		path 	=> $exec_path
	}
	->
	{"install unzip":
		comment	=> "sudo apt-get install unzip",
		path 	=> $exec_path
	}
	->
	#fetch sdkman
	exec{"fetch and install sdkman":
		command =>	"curl -s get.sdkman.io | bash",
		path 	=>	$exec_path
	}
	->
	#be sure in environment
	#exec{"ensure sdkman in environment":
	#	command	=>	". \"~/.sdkman/bin/sdkman-init.sh\"",
	#	path 	=>	$exec_path
	#}
	#->
	#install groovy via sdk, and mark as default
	exec{"install groovy ver ${groovy_ver}":
		command	=> "y | sdk install groovy ${groovy_ver}",
		path 	=> $exec_path
	}
	->
	#install grails via sdk, and mark as default
	exec{"install grails ver ${grails_ver}":
		command	=> "y | sdk install grails ${grails_ver}",
		path 	=> $exec_path
	}
}