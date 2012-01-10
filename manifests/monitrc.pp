define monit::monitrc($monitinterval=60,
		      $mailserver='smtp.example.com',
		      $port=25,
		      $username="\'monit@example.com\'",
		      $password="\'m0n1t@207\'",
		      $fqdn,
		      $hostname,
		      $rootfs="",
		      $datafs="") {
 file {"/etc/monit/monitrc" :
 	ensure => $ensure,
	content => template("monit/monitrc.erb"),
	require => File["monit binary"],
	notify => Service[monit]
	}
}
