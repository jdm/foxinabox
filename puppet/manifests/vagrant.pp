#
# Playdoh puppet magic for dev boxes
#
import "classes/*.pp"

$PROJ_DIR = "/home/vagrant/project"

class dev {
    class {
        init: before => Class[builddeps];
        hg: before => Class[source];
        builddeps: ;
        source: ;
    }
}

include dev