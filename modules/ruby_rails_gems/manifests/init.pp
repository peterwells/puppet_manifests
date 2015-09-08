class ruby_rails_gems{

  exec {"get rbenv":
	command =>	"git clone https://github.com/sstephenson/rbenv ${rbenv_root}",
	path =>		$exec_path,
	onlyif =>   "test ! -e ${rbenv_root}"
  }
  ->
  exec {"update ruby_build":
	command =>	"git clone https://github.com/sstephenson/ruby-build ${ruby_build_root}",
	path =>		$exec_path,
	onlyif =>   "test ! -e ${ruby_build_root}"
  }
  ->
  exec {"set permissions on rbenv home":
  command => "chown -R vagrant:vagrant ${rbenv_root}",
  path  => $exec_path
  }
  ->
  exec {"set permissions on ruby-build":
  command => "chown -R vagrant:vagrant ${ruby_build_root}",
  path  => $exec_path
  }
  ->
  exec {"bash install.sh":
	cwd => 		$ruby_build_root,
	path => 	$exec_path
  }
  ->
  #this shell file does not work, remove and replace below
  exec {"rm rbenv":
	path => 	$exec_path,
	cwd => 		"${rbenv_root}/bin",
	user => 	$user
  }
  ->
  exec {"ln -s ${rbenv_root}/libexec/rbenv rbenv":
	path => 	$exec_path,
	cwd => 		"${rbenv_root}/bin",
	user => 	$user
  }
  ->
  # installing prerequisites for Ruby
  exec {"sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev postgresql postgresql-contrib pgadmin3 libpq-dev":
  path  =>  $exec_path,
  timeout =>  0
  }
  ->
  exec {"ruby-build ${ruby_ver} ${rbenv_root}/versions/${ruby_ver}":
	path => 	$exec_path,
	timeout => 	0,
	user => 	$user
  }
  ->
  exec {"env PATH=${exec_path} bash -c 'eval \"\$(rbenv init -)\"'":
	path => 	$exec_path,
	user => 	$user
  }
  ->
# RAILS
  exec {"yes | ${rbenv_root}/versions/${ruby_ver}/bin/gem install rails --version '${rails_ver}' --no-document":
	path => 	$exec_path,
	user => 	$user,
	timeout => 	0
  }
  ->
# OCI8 to connect to oracle
  exec {"${rbenv_root}/versions/${ruby_ver}/bin/gem install ruby-oci8 --no-document":
	path => 	$exec_path,
	user => 	$user,
	timeout => 	0
  }
  ->
# Unicorn as application server
  exec {"${rbenv_root}/versions/${ruby_ver}/bin/gem install unicorn --no-document":
	path => 	$exec_path,
	user => 	$user,
	timeout => 	0
  }
  ->  
# Capybara
  exec {"${rbenv_root}/versions/${ruby_ver}/bin/gem install capybara --no-document":
	path => 	$exec_path,
	user => 	$user,
	timeout => 	0
  }
  
# ENVIRONMENTAL SETTINGS
  exec {"bash -c 'echo \"export PATH=${exec_path}\" >> /home/${user}/.bashrc'":
	path => 	$exec_path,
	user => 	$user
  }
  -> 
  exec {"bash -c 'echo \"${rbenv_init_statement}\" >> /home/${user}/.bashrc'":
	path => 	$exec_path,
	user => 	$user
  }
  ->
  exec {"bash -c 'echo \"rbenv global ${ruby_ver} --default\" >> /home/${user}/.bashrc'":
	path => 	$exec_path,
	user => 	$user
  }
}
