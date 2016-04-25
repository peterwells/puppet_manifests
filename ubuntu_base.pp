#This file sets environment variables needed by the included modules

$base_dir = "/vagrant"
$user = vagrant

# ruby environent variables
$ruby_ver = "2.0.0-p647"
$rails_ver = "4.2.4"
$rbenv_root = "/home/${user}/.rbenv"
$ruby_build_root = "/home/${user}/ruby_build"
$rbenv_src = "${base_dir}/rbenv_git"
$rbenv_init_statement = 'eval \"\$(rbenv init -)\"'

# oracle instant client environment variables
$oracle_version_long = "12.1.0.1.0"
$oracle_version_short = "12.1"
$oracle_install_path = "/usr/lib/oracle"
$oracle_source_path = "/vagrant/manifests/modules/oracle_instant"
$oracle_basic_filename = "oracle-instantclient${oracle_version_short}-basic-${oracle_version_long}-1.x86_64"
$oracle_sqlplus_filename = "oracle-instantclient${oracle_version_short}-sqlplus-${oracle_version_long}-1.x86_64"
$oracle_devel_filename = "oracle-instantclient${oracle_version_short}-devel-${oracle_version_long}-1.x86_64"
$tns_admin_path = "/usr/lib/oracle/${oracle_version_short}/client64/network/admin"
$ld_library_path = "/usr/lib/oracle/${oracle_version_short}/client64/lib"
$oracle_home_path ="/usr/lib/oracle/${oracle_version_short}/client64"

# openresty environment variables
$openresty_src = "${base_dir}/openresty/src"
$openresty_root = "/home/${user}/openresty"
$openresty_filename = "ngx_openresty-1.9.3.1"

# groovy environmental variables
$groovy_ver = "2.1.9"
$grails_ver = "2.3.7"

$targz_suffix = ".tar.gz"
$exec_path = "${rbenv_root}/bin:${rbenv_root}/shims:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin"

package {"man":
	ensure => latest
}

package {"git":
	ensure => latest,
	provider => apt
}

package {"libaio1":
	ensure => latest,
	provider => apt
}

package {"libaio-dev":
	ensure => latest,
	provider => apt
}
#exec {"installing gui":
#	command => 	"sudo apt-get install -y ubuntu-desktop",
#	path	=>	$exec_path
#}

exec {"ensuring puppet stdlib installed":
	command => "puppet module install puppetlabs-stdlib",
	path	=> $exec_path
}

include oracle_instant
#include ruby_rails_gems
#include openresty
#include nodejs
#include aws-cli
include groovy_grails