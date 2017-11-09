define pam::service (
  Stdlib::Absolutepath $etcpamd = $::pam::etcpamd,
  Array[Hash] $entries          = [],
) {
  $service = $name

  concat { $service:
    path   => "${etcpamd}/${service}",
    ensure => present,
  }

  $entries.each | Hash $entry | {
    pam::entry { "${name}-${entry['module']}":
      service => $name,
      type    => $entry['type'],
      module  => $entry['module'],
      control => $entry['control'],
      order   => $entry['order'],
      require => Concat[$service],
    }
  }

}
