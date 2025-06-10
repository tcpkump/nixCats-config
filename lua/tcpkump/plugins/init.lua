require('tcpkump.plugins.completion')
require('tcpkump.plugins.neotree')
require('tcpkump.plugins.smart_splits')
require('tcpkump.plugins.git')

require('lze').load {
  { import  = 'tcpkump.plugins.telescope' },
  { import  = 'tcpkump.plugins.lazygit' },
}
