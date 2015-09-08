class oracle_instant {

  # Check that needed files are present
  file {'oracle install directory':
	ensure => 	directory,
	path => 	"${oracle_install_path}",
	owner => 	$user
  }
  ->	
  file { "${oracle_basic_filename}":
	ensure => 	file,
	path => 	"${oracle_install_path}/${oracle_basic_filename}.rpm",
	source => 	"file://${oracle_source_path}/${oracle_basic_filename}.rpm"
  }
  ->
  file { "${oracle_sqlplus_filename}":
	ensure => 	file,
	path => 	"${oracle_install_path}/${oracle_sqlplus_filename}.rpm",
	source => 	"file://${oracle_source_path}/${oracle_sqlplus_filename}.rpm"
  }
  ->
  file { "${oracle_devel_filename}":
  ensure => 	file,
	path => 	"${oracle_install_path}/${oracle_devel_filename}.rpm",
	source => 	"file://${oracle_source_path}/${oracle_devel_filename}.rpm"
  }
  -> 
  # get conversion software
  exec {"sudo apt-get install -y alien dpkg-dev debhelper build-essential":
  path  => $exec_path
  }
  ->
  # convert files to deb and install
  exec {"sudo alien -i ${oracle_install_path}/${oracle_basic_filename}.rpm":
  cwd =>    $oracle_install_path,
  path =>   $exec_path
  }
  ->
  exec {"sudo alien -i ${oracle_install_path}/${oracle_sqlplus_filename}.rpm":
  cwd =>    $oracle_install_path,
  path =>   $exec_path
  }
  ->
  exec {"sudo alien -i ${oracle_install_path}/${oracle_devel_filename}.rpm":
  cwd =>    $oracle_install_path,
  path =>   $exec_path
  }
  ->
  # set some environmental stuff
  file { 'oracle.conf':
	ensure => 	file,
	path => 	"/etc/ld.so.conf.d/oracle.conf",
	content => 	"/usr/lib/oracle/${oracle_version_short}/client64/lib\n"
  }
  ->
  exec {"ldconfig":
	command => 	"ldconfig",
	path => 	$exec_path
  }
  ->
  file { 'oracle.sh':
	ensure => 	file,
	path => 	"/etc/profile.d/oracle.sh",
	content => 	"export ORACLE_HOME=/usr/lib/oracle/${oracle_version_short}/client64\n export TNS_ADMIN=/usr/lib/oracle/${oracle_version_short}/client64/network/admin\n"
  }
  ->
  file {'oracle network directory':
	ensure => 	directory,
	path => 	"/usr/lib/oracle/${oracle_version_short}/client64/network"
  }
  ->
  file {'oracle network admin directory':
	ensure => 	directory,
	path => 	"/usr/lib/oracle/${oracle_version_short}/client64/network/admin"
  }
  ->
  file { 'ldap.ora':
	ensure => 	file,
	path => 	"/usr/lib/oracle/${oracle_version_short}/client64/network/admin/ldap.ora",
	source => 	"${oracle_source_path}/ldap.ora"
  }
  ->
  file { 'sqlnet.ora':
	ensure => 	file,
	path => 	"/usr/lib/oracle/${oracle_version_short}/client64/network/admin/sqlnet.ora",
	source => 	"${oracle_source_path}/sqlnet.ora"
  }
  ->
  file { 'tnsnames.ora':
	ensure => 	file,
	path => 	"/usr/lib/oracle/${oracle_version_short}/client64/network/admin/tnsnames.ora",
	source => 	"${oracle_source_path}/tnsnames.ora"
  }
  ->
  # ENVIRONMENTAL SETTINGS
  exec {"bash -c 'echo \"export ORACLE_HOME=${oracle_home_path}\" >> /home/${user}/.bashrc'":
	path => 	$exec_path,
	user => 	$user
  }
  ->
  exec {"bash -c 'echo \"export LD_LIBRARY_PATH=${ld_library_path}\" >> /home/${user}/.bashrc'":
	path => 	$exec_path,
	user => 	$user
  }
  ->
  exec {"bash -c 'echo \"export TNS_ADMIN=${tns_admin_path}\" >> /home/${user}/.bashrc'":
	path => 	$exec_path,
	user => 	$user
  }
}

