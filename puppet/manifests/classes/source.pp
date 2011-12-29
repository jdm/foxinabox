class source {
    exec { "clone-mc":
        command => "/usr/bin/hg clone http://hg.mozilla.org/mozilla-central /home/vagrant/mozilla-central",
        require => [Package['mercurial']],
        creates => "/home/vagrant/mozilla-central/LICENSE",
        user => "vagrant",
        timeout => 0,
        logoutput => true;
    } ->

    exec { "mozconfig":
        command => "/bin/echo 'ac_add_options --disable-debug-symbols; export LDFLAGS=\"-Wl,--no-keep-memory\"; ac_add_options --enable-application=browser; mk_add_options MOZ_MAKE_FLAGS=\"-j2\"' >/home/vagrant/mozilla-central/.mozconfig",
        creates => "/home/vagrant/mozilla-central/.mozconfig",
        user => "vagrant"
    }
}
