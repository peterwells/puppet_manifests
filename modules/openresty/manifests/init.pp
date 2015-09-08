class openresty {
  package {'libreadline-dev':
	ensure =>	latest
  }
  ->
  package {'libpcre3-dev':
	ensure =>	latest
  }
  ->
  package {'libssl-dev':
	ensure =>	latest
  }
  ->
  package {'perl':
	ensure =>	installed
  }
  ->
  package {'make':
	ensure =>	installed
  }
  ->
  file {"openresty install dir":
	ensure =>	directory,
  	path => 	"${openresty_root}",
	mode =>		"0755",
	owner =>	$user
  }
  ->
  exec {"wget -O ${openresty_root}/${openresty_filename}${targz_suffix} http://openresty.org/download/${openresty_filename}${targz_suffix}":
	path => 	$exec_path,
	user => 	$user,
  }
  ->	
  file {"${openresty_filename}${targz_suffix}":
	ensure =>	file,
	path => 	"${openresty_root}/${openresty_filename}${targz_suffix}",
	mode => 	"0755",
	owner => 	$user
  }
  ->
  exec {"tar -xzf ${openresty_filename}${targz_suffix}":
	path => 	$exec_path,
	user => 	$user,
	cwd =>		$openresty_root
  }
  ->
  exec {"${openresty_root}/${openresty_filename}/configure --with-luajit":
	path => 	$exec_path,
	cwd =>		"${openresty_root}/${openresty_filename}",
	user =>		$user
  }
  ->
  exec {"make -j2":
	path => 	$exec_path,
	cwd =>		"${openresty_root}/${openresty_filename}",
	user =>		$user
  }
  ->
  exec {"make install":
	path => 	$exec_path,
	cwd =>		"${openresty_root}/${openresty_filename}"
  }
	
  
}