class pam::params {
  $etcpamd     = '/etc/pam.d'
  $sss_enabled = true
  case $facts['os']['family'] {
    'Suse': {
      $services_sss = {
        common-account-pc_test => [
          {
            type    => 'account',
            module  => 'localuser',
            control => 'sufficient',
            order   => 50,
          },
          {
            type    => 'account',
            module  => 'sss',
            control => 'required',
            order   => 60,
          }
        ]
      }
      $services = {
        common-account-pc_test => [
          {
            type    => 'account',
            module  => 'unix',
            control => 'requisite',
            order   => 10,
          }
        ]
      }      
    }
    'Debian': {
      $services_sss = {
        common-account_test => [
          {
            type    => 'account',
            module  => 'access',
            control => 'required',
            order   => 40,
          },
          {
            type    => 'account',
            module  => 'localuser',
            control => 'sufficient',
            order   => 50,
          },
          {
            type    => 'account',
            module  => 'sss',
            control => '[default=bad success=ok user_unknown=ignore]',
            order   => 60,
          }
        ]
      }
      $services = {
        common-account_test => [
          {
            type    => 'account',
            module  => 'unix',
            control => '[success=1 new_authtok_reqd=done default=ignore]',
            order   => 10,
          },
          {
            type    => 'account',
            module  => 'deny',
            control => 'requisite',
            order   => 20,
          },
          {
            type    => 'account',
            module  => 'permit',
            control => 'required',
            order   => 30,
          },
        ]
      }      
    }
    default: {
      $services = {}
      $services_sss = {}
    }
  }
}
