class source {
    exec { "clone-mc":
        command => "/usr/bin/hg clone http://hg.mozilla.org/mozilla-central /home/vagrant//mozilla-central",
        require => [Package['mercurial']],
        creates => "/home/vagrant/mozilla-central/LICENSE",
        user => "vagrant",
        timeout => 0,
        logoutput => true;
    }
}