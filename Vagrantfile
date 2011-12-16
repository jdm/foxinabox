Vagrant::Config.run do |config|
    config.vm.box = "foxinabox"
    config.vm.box_url = "https://github.com/downloads/divio/vagrant-boxes/vagrant-ubuntu-11.04-server-amd64-v1.box"

    #config.vm.boot_mode   = :gui

    # Increase vagrant's patience during hang-y CentOS bootup
    # see: https://github.com/jedi4ever/veewee/issues/14
    config.ssh.max_tries = 50
    config.ssh.timeout = 300

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file = "vagrant.pp"
    end
end

