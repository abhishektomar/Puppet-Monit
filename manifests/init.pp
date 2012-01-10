class monit($ensure=present) {
  
  case $architecture {
   amd64, x86_64: { $binary = "x64/monit" }
   i386: { $binary = "i386/monit" }
  }
  file { "monit binary" :
  	path => "/usr/local/sbin/monit",
  	ensure => $ensure,
  	owner => root,
	group => root,
	mode => 0700,
	source => "puppet:///monit/binary/$binary",
	}
  file { "/etc/init.d/monit" :
	ensure => $ensure,
	source => "puppet:///monit/binary/monit",
	require => File["monit binary"],
	}
  file {"/etc/default/monit":
        ensure => $ensure,
        source => "puppet:///monit/monit/monit.default",
	}	
  File {
        owner => "root",
        group => "root",
        mode => 0700,
        notify => Exec["monit reload"],
        }
  file { "/etc/monitrc" :
        ensure => file,
        path => '/etc/monitrc',
        content => "include /etc/monit/monitrc",
        }
  file { "/etc/monit":
        ensure => directory,
        mode => 0700,
        }       
  file { "/etc/monit/conf.d":
        ensure => directory,
        mode => 0700,
        }     
  service { "monit":
  	ensure => running,
	enable => true,
	}
  exec { "monit reload":
	command => "/usr/local/sbin/monit reload",
	refreshonly => true,
	}
}
