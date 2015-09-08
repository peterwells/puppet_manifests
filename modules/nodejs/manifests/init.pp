class nodejs{
	exec {"sudo apt-get install -y nodejs":
		path 	=>	$exec_path
	}
	#exec {"curl -O http://download-i2.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm":
	#	cwd => 		"/home/${user}",
	#	path => 	$exec_path,
	#	logoutput =>	true
	#}
	#->
	#exec {"sudo rpm -ivh --force epel-release-6-8.noarch.rpm":
	#	cwd =>		"/home/${user}",
	#	path => 	$exec_path,
	#	logoutput =>	true
	#}
	#->
	#exec {"sudo yum -y install npm --enablerepo=epel":
	#	cwd =>		"/home/${user}",
	#	path => 	$exec_path,
	#	logoutput =>	true
	#}	
}