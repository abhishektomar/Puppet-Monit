define monit::ssh($sshdaemon,
		   $ssh_port) {

	file {"ssh_monit" :
	      path => "/etc/monit/conf.d/ssh.monit",
	      content => template("monit/ssh.erb"),
	      notify => Exec["monit reload"],
	}
}
