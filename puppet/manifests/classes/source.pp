class source {
    exec { "grab-bundle":
        command => "/usr/bin/wget http://ftp.mozilla.org/pub/mozilla.org/firefox/bundles/mozilla-central.hg",
        creates => "/home/vagrant/mozilla-central.hg",
        cwd => "/home/vagrant",
        user => "vagrant",
        timeout => 0,
        logoutput => "on_failure",
        unless => "/usr/bin/test -d /home/vagrant/mozilla-central"
    } ->
    exec { "init":
        command => "/usr/bin/hg init mozilla-central",
        require => [Package['mercurial']],
        user => "vagrant",
        cwd => "/home/vagrant",
        unless => "/usr/bin/test -d /home/vagrant/mozilla-central"
    } ->
    exec { "unbundle":
        command => "/usr/bin/hg unbundle /home/vagrant/mozilla-central.hg",
        require => [Package['mercurial']],
        cwd => "/home/vagrant/mozilla-central",
        creates => "/home/vagrant/mozilla-central/LICENSE",
        user => "vagrant",
        timeout => 0,
        logoutput => true,
        unless => "/usr/bin/test -d /home/vagrant/mozilla-central"
    } ->
    file { "/home/vagrant/mozilla-central/.hg/hgrc":
        ensure => present,
        owner => "vagrant",
        content => "[paths]
default = http://hg.mozilla.org/mozilla-central/"
    } ->
    exec { "pull":
        command => "/usr/bin/hg pull -u",
        require => [Package['mercurial']],
        cwd => "/home/vagrant/mozilla-central",
        user => "vagrant",
        timeout => 0,
        logoutput => true,
        onlyif => "/usr/bin/test -f /home/vagrant/mozilla-central.hg"
    } ->
    file { "/home/vagrant/mozilla-central/.mozconfig":
        ensure => present,
        owner => "vagrant",
        content => "ac_add_options --disable-debug-symbols
export LDFLAGS='-Wl,--no-keep-memory'
ac_add_options --enable-application=browser
mk_add_options MOZ_MAKE_FLAGS='-j2'"
    } ->
    exec { "cleanup":
        command => "/bin/rm /home/vagrant/mozilla-central.hg",
        onlyif => "/usr/bin/test -f /home/vagrant/mozilla-central.hg"
    }
}
