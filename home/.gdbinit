python

import sys, os

sys.path.insert(0, os.path.expanduser('~/.gdb/') + 'pretty-printers/')

from qt import register_qt_printers
register_qt_printers (None)

end
