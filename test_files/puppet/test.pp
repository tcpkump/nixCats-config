# Test Puppet file with intentional issues for verifying puppet-lint diagnostics

class example_class {
  # This line is intentionally very long to test line length warnings - it should trigger puppet-lint warning about lines exceeding 140 characters which is the default limit

  file { '/tmp/test':
    ensure => present,
    mode => '0644',
  }

  # Missing trailing comma (should trigger warning)
  package { 'nginx':
    ensure => installed
  }

  # Variable not enclosed in braces (should trigger warning)
  notify { "The value is $somevar": }

  # Double quoted string when single quotes should be used
  $myvar = "simple_string"

  # Hard tab character (should trigger warning if tabs are not allowed)
	$another_var = 'test'
}
