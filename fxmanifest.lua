fx_version 'cerulean'

games {"gta5", "rdr3"}

author "qw-scripts"
description "black-market script for FiveM"
version '0.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"
server_script "server/**/*"

shared_scripts { 'shared/config.lua' }

files {
  'web/build/index.html',
  'web/build/**/*'
}
