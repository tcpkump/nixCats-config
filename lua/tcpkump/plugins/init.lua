require('tcpkump.plugins.completion')
require('tcpkump.plugins.neotree')
require('tcpkump.plugins.smart_splits')
require('tcpkump.plugins.git')
require('tcpkump.plugins.statusline')
require('tcpkump.plugins.mini')

require('lze').load {
  { import  = 'tcpkump.plugins.telescope' },
  { import  = 'tcpkump.plugins.git_lazy' },
}
