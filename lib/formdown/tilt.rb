require 'tilt'
require 'tilt/formdown'

# TODO - Support lazy registration when Middleman supports Tilt 2.x.
# Tilt.register_lazy :FormdownTemplate, 'tilt/formdown', 'formdown', 'fmd'
Tilt.register Tilt::FormdownTemplate, *Formdown::FILE_EXTENSIONS